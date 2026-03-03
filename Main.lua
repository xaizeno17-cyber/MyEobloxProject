local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ PUSAT KOORDINAT & KONFIGURASI ]] --
_G.FarmingActive = false
_G.FarmSpeed = 0.3 -- Default awal
_G.TargetX = 0     -- Pusat Karakter (0)
_G.TargetY = 0     -- Pusat Karakter (0)

local Window = Rayfield:CreateWindow({
   Name = "Supreme Farmer | Precision Grid",
   LoadingTitle = "Calibrating Relative Coordinates...",
   LoadingSubtitle = "by xaizeno17-cyber",
   ConfigurationSaving = {Enabled = false}
})

local Tab = Window:CreateTab("Auto-Farm", 4483345998)

Tab:CreateToggle({
   Name = "Start Auto-Farm",
   CurrentValue = false,
   Callback = function(Value)
      _G.FarmingActive = Value
      if _G.FarmingActive then
         spawn(function()
            local VU = game:GetService("VirtualUser")
            while _G.FarmingActive do
               pcall(function()
                  local Char = game.Players.LocalPlayer.Character
                  local HRP = Char:FindFirstChild("HumanoidRootPart")
                  local Tool = Char:FindFirstChildOfClass("Tool")
                  
                  if HRP then
                     -- POSISI RELATIF: Menjadikan Player sebagai titik 0,0
                     -- Mengkonversi koordinat lokal slider ke koordinat dunia (World Space)
                     local RelativeOffset = Vector3.new(_G.TargetX * 5, _G.TargetY * 5, -5)
                     local WorldTarget = HRP.CFrame:PointToWorldSpace(RelativeOffset)
                     
                     -- CEK BLOK DI TARGET
                     local RayParam = RaycastParams.new()
                     RayParam.FilterDescendantsInstances = {Char}
                     local Check = workspace:Raycast(HRP.Position, (WorldTarget - HRP.Position), RayParam)
                     
                     if Check and Check.Instance then
                        -- JIKA ADA BLOK -> PUKUL (BREAK)
                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, WorldTarget)
                        VU:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                        task.wait(0.05)
                        VU:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                     else
                        -- JIKA KOSONG -> LETAKKAN (PLACE)
                        if Tool then
                           Tool:Activate()
                        end
                     end
                  end
               end)
               task.wait(_G.FarmSpeed)
            end
         end)
      end
   end,
})

Tab:CreateSection("Custom Range & Speed")

-- SLIDER KECEPATAN: 0.1 sampai 2.0 Detik
Tab:CreateSlider({
   Name = "Jeda Memukul (0.1 - 2.0 Detik)",
   Min = 0.1,
   Max = 2,
   CurrentValue = 0.3,
   Callback = function(Value) _G.FarmSpeed = Value end,
})

-- SLIDER RANGE X: -3 sampai 3 (Relatif terhadap Player)
Tab:CreateSlider({
   Name = "Geser X (Kiri -3 / Kanan 3)",
   Min = -3,
   Max = 3,
   CurrentValue = 0,
   Callback = function(Value) _G.TargetX = Value end,
})

-- SLIDER RANGE Y: -3 sampai 3 (Relatif terhadap Player)
Tab:CreateSlider({
   Name = "Geser Y (Bawah -3 / Atas 3)",
   Min = -3,
   Max = 3,
   CurrentValue = 0,
   Callback = function(Value) _G.TargetY = Value end,
})

Rayfield:Notify({Title = "Master Updated", Content = "Speed 0.1-2s & Grid Pusat Karakter Aktif!", Duration = 5})