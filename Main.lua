local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ DETEKSI GAME ]] --
local isGrowGarden = (game.Name == "Grow a Garden" or game.PlaceId == 123456789) 
local isCraftWorld = (game.Name == "Craft a World" or game.PlaceId == 1000786804)

-- [[ VARIABEL GLOBAL ]] --
local SpeedEnabled = false
local targetSpeed = 16
local InfJump = false
local FarmingActive = false
local FarmSpeed = 0.2
local TargetX = 0
local TargetY = 0

local Window = Rayfield:CreateWindow({
   Name = "Supreme Universal | " .. (isGrowGarden and "Grow Edition" or (isCraftWorld and "Craft Edition" or "Universal")),
   LoadingTitle = "Booting Master Engine...",
   LoadingSubtitle = "by xaizeno17-cyber",
   ConfigurationSaving = {Enabled = true, FolderName = "SupremeUniversal"},
   KeySystem = false 
})

-- [[ TAB 1: KARAKTER ]] --
local Tab1 = Window:CreateTab("Karakter", 4483345998)

Tab1:CreateInput({
   Name = "Set Speed (0-300)",
   PlaceholderText = "Default 16",
   Callback = function(Text)
      local s = tonumber(Text)
      if s then
         targetSpeed = s
         SpeedEnabled = (s > 16)
         pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s end)
      end
   end,
})

Tab1:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value) InfJump = Value end,
})

-- [[ TAB 2: AUTO-FARM (GRID SYSTEM) ]] --
local Tab2 = Window:CreateTab("Auto-Farm", 4483345998)

if isCraftWorld or isGrowGarden then
    Tab2:CreateToggle({
       Name = "Enable Grid Auto-Farm",
       CurrentValue = false,
       Callback = function(Value)
          FarmingActive = Value
          if FarmingActive then
             spawn(function()
                while FarmingActive do
                   local Player = game.Players.LocalPlayer
                   local Character = Player.Character
                   if Character and Character:FindFirstChild("HumanoidRootPart") then
                      local Tool = Character:FindFirstChildOfClass("Tool")
                      
                      if Tool then
                         -- Kalkulasi posisi target berdasarkan Grid (5 unit = 1 block)
                         local Offset = Vector3.new(TargetX * 5, TargetY * 5, -5) 
                         local WorldPos = Character.HumanoidRootPart.CFrame * Offset
                         
                         -- Cek apakah ada block di depannya
                         local RayParam = RaycastParams.new()
                         RayParam.FilterDescendantsInstances = {Character}
                         local Check = workspace:Raycast(Character.HumanoidRootPart.Position, (WorldPos.Position - Character.HumanoidRootPart.Position), RayParam)
                         
                         if Check and Check.Instance then
                            -- JIKA ADA BLOK -> BREAK
                            game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                         else
                            -- JIKA KOSONG -> PLACE
                            Tool:Activate()
                            
                            -- Notif jika item habis (tool terlepas)
                            if not Character:FindFirstChildOfClass("Tool") then
                               Rayfield:Notify({Title = "Master Alert", Content = "Item di tangan habis atau tidak bisa diletakkan!", Duration = 2})
                               -- Kita tidak mematikan toggle agar user bisa ganti item
                            end
                         end
                      else
                         -- Jika tangan kosong
                         -- Rayfield:Notify({Title = "Warning", Content = "Pegang item untuk memulai!", Duration = 1})
                      end
                   end
                   task.wait(FarmSpeed)
                end
             end)
          end
       end,
    })

    Tab2:CreateSection("Farm Settings (Grid & Speed)")

    Tab2:CreateSlider({
       Name = "Action Speed (Detik)",
       Min = 0.05,
       Max = 1,
       CurrentValue = 0.2,
       Callback = function(Value) FarmSpeed = Value end,
    })

    Tab2:CreateSlider({
       Name = "Grid X (Kiri -3 / Kanan 3)",
       Min = -3,
       Max = 3,
       CurrentValue = 0,
       Callback = function(Value) TargetX = Value end,
    })

    Tab2:CreateSlider({
       Name = "Grid Y (Bawah -3 / Atas 3)",
       Min = -3,
       Max = 3,
       CurrentValue = 0,
       Callback = function(Value) TargetY = Value end,
    })
else
    Tab2:CreateLabel("Game ini tidak didukung untuk Auto-Farm Grid.")
end

-- [[ LOGIC BYPASS SPEED (CFrame) ]] --
game:GetService("RunService").RenderStepped:Connect(function()
    if SpeedEnabled then
        pcall(function()
            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
            local hum = game.Players.LocalPlayer.Character.Humanoid
            if hum.MoveDirection.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (targetSpeed / 100))
            end
        end)
    end
end)

-- [[ LOGIC INFINITE JUMP ]] --
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfJump then
        pcall(function()
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end)
    end
end)

-- [[ FLOATING BUTTON UNTUK MINIMIZE ]] --
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 80, 0, 30)
OpenButton.Position = UDim2.new(0, 10, 0, 50)
OpenButton.Text = "Show UI"
OpenButton.Draggable = true
OpenButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
OpenButton.TextColor3 = Color3.new(1,1,1)
OpenButton.MouseButton1Click:Connect(function()
    Rayfield:Notify({Title = "UI Info", Content = "Tekan RCTRL untuk memunculkan menu", Duration = 2})
end)

Rayfield:Notify({Title = "Master Loaded", Content = "Siap bertani di " .. game.Name, Duration = 5})
