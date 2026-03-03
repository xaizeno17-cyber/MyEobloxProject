local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ VARIABEL GLOBAL - MENGGUNAKAN TABEL AGAR REAL-TIME ]] --
_G.SupremeConfig = {
    Farming = false,
    Speed = 0.3,
    X = 0,
    Y = 0
}

local Window = Rayfield:CreateWindow({
   Name = "Supreme Farmer | Craft Edition",
   LoadingTitle = "Focusing Logic...",
   LoadingSubtitle = "by xaizeno17-cyber",
   ConfigurationSaving = {Enabled = false}
})

local TabFarm = Window:CreateTab("Auto-Farm", 4483345998)

TabFarm:CreateToggle({
   Name = "Enable Grid Auto-Farm",
   CurrentValue = false,
   Callback = function(Value)
      _G.SupremeConfig.Farming = Value
      if Value then
         spawn(function()
            local VU = game:GetService("VirtualUser")
            VU:CaptureController()
            
            while _G.SupremeConfig.Farming do
               pcall(function()
                  local Char = game.Players.LocalPlayer.Character
                  local HRP = Char:FindFirstChild("HumanoidRootPart")
                  local Tool = Char:FindFirstChildOfClass("Tool")
                  
                  if HRP then
                     -- JARAK PER BLOK DI GAME INI BIASANYA 4-5 STUDS
                     -- Kita hitung posisi target tepat di depan karakter sesuai Grid
                     local TargetCFrame = HRP.CFrame * CFrame.new(_G.SupremeConfig.X * 4, _G.SupremeConfig.Y * 4, -4)
                     local TargetPos = TargetCFrame.Position
                     
                     -- CEK APAKAH ADA BLOK DI TITIK TERSEBUT
                     local Region = Region3.new(TargetPos - Vector3.new(1,1,1), TargetPos + Vector3.new(1,1,1))
                     local Parts = workspace:FindPartsInRegion3(Region, Char, 10)
                     
                     local FoundBlock = false
                     for _, part in pairs(Parts) do
                        if part:IsA("BasePart") and part.CanCollide then
                           FoundBlock = true
                           break
                        end
                     end

                     if FoundBlock then
                        -- TAHAP 1: HANCURKAN (BREAK)
                        -- Mengarahkan kamera ke blok agar pukulan masuk
                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, TargetPos)
                        VU:ClickButton1(Vector2.new(0,0))
                     else
                        -- TAHAP 2: LETAKKAN (PLACE)
                        if Tool then
                           Tool:Activate()
                        else
                           -- Jika tangan kosong, tetap pukul untuk memastikan area bersih
                           VU:ClickButton1(Vector2.new(0,0))
                        end
                     end
                  end
               end)
               task.wait(_G.SupremeConfig.Speed)
            end
         end)
      end
   end,
})

TabFarm:CreateSection("Konfigurasi Presisi")

-- Perbaikan Slider: Menghapus embel-embel "studs" agar terbaca angka murni
TabFarm:CreateSlider({
   Name = "Jeda Memukul (Detik)",
   Min = 0.1,
   Max = 1,
   CurrentValue = 0.3,
   Callback = function(Value) 
      _G.SupremeConfig.Speed = Value 
   end,
})

TabFarm:CreateSlider({
   Name = "Geser X (Kiri -3 / Kanan 3)",
   Min = -3,
   Max = 3,
   CurrentValue = 0,
   Callback = function(Value) 
      _G.SupremeConfig.X = Value 
   end,
})

TabFarm:CreateSlider({
   Name = "Geser Y (Bawah -3 / Atas 3)",
   Min = -3,
   Max = 3,
   CurrentValue = 0,
   Callback = function(Value) 
      _G.SupremeConfig.Y = Value 
   end,
})

-- Tombol Show UI agar tidak hilang (Floating)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 80, 0, 30)
OpenBtn.Position = UDim2.new(0, 10, 0, 120)
OpenBtn.Text = "Menu"
OpenBtn.Draggable = true
OpenBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.MouseButton1Click:Connect(function()
    Rayfield:Notify({Title = "Master Hub", Content = "Tekan RCTRL jika UI tidak terlihat", Duration = 2})
end)
