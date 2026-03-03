local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ VARIABEL GLOBAL (FIXED) ]] --
_G.FarmingActive = false
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ VARIABEL GLOBAL (FIXED) ]] --
_G.FarmingActive = false
_G.FarmSpeed = 0.3
_G.TargetX = 0
_G.TargetY = 0

local Window = Rayfield:CreateWindow({
   Name = "Supreme Farmer | Overdrive Edition",
   LoadingTitle = "Master Logic Initializing...",
   LoadingSubtitle = "by xaizeno17-cyber",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false 
})

-- [[ TAB UTAMA: AUTO-FARM ]] --
local TabFarm = Window:CreateTab("Auto-Farm", 4483345998)

TabFarm:CreateToggle({
   Name = "Enable Grid Auto-Farm",
   CurrentValue = false,
   Callback = function(Value)
      _G.FarmingActive = Value
      if _G.FarmingActive then
         spawn(function()
            -- Memastikan input terdeteksi game
            game:GetService("VirtualUser"):CaptureController()
            
            while _G.FarmingActive do
               pcall(function()
                  local Player = game.Players.LocalPlayer
                  local Character = Player.Character
                  local HRP = Character:FindFirstChild("HumanoidRootPart")
                  local Tool = Character:FindFirstChildOfClass("Tool")
                  
                  if HRP then
                     -- KALKULASI GRID PRESISI (Unit 5 = 1 Block)
                     local TargetPos = HRP.CFrame * CFrame.new(_G.TargetX * 5, _G.TargetY * 5, -5)
                     
                     -- CEK OBJEK (Raycast)
                     local RayParam = RaycastParams.new()
                     RayParam.FilterDescendantsInstances = {Character}
                     local Check = workspace:Raycast(HRP.Position, (TargetPos.Position - HRP.Position), RayParam)
                     
                     if Check and Check.Instance and Check.Instance:IsA("BasePart") then
                        -- TAHAP 1: BREAK (Pukul Blok yang Terdeteksi)
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                     else
                        -- TAHAP 2: PLACE (Gunakan Item Apapun di Tangan)
                        if Tool then
                           Tool:Activate()
                        else
                           -- Jika Tangan Kosong, Tetap Pukul (Punch)
                           game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
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

TabFarm:CreateSection("Farm Configuration")

TabFarm:CreateSlider({
   Name = "Kecepatan Memukul (Detik)",
   Min = 0.1,
   Max = 1,
   CurrentValue = 0.3,
   Callback = function(Value) _G.FarmSpeed = Value end,
})

TabFarm:CreateSlider({
   Name = "Range Grid X (Kiri -3 / Kanan 3)",
   Min = -3,
   Max = 3,
   CurrentValue = 0,
   Callback = function(Value) _G.TargetX = Value end,
})

TabFarm:CreateSlider({
   Name = "Range Grid Y (Bawah -3 / Atas 3)",
   Min = -3,
   Max = 3,
   CurrentValue = 0,
   Callback = function(Value) _G.TargetY = Value end,
})

-- Tombol Show UI Cadangan
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 80, 0, 30)
OpenBtn.Position = UDim2.new(0, 10, 0, 80)
OpenBtn.Text = "Show Menu"
OpenBtn.Draggable = true
OpenBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.MouseButton1Click:Connect(function()
    Rayfield:Notify({Title = "Hint", Content = "Tekan RCTRL untuk Toggle UI", Duration = 2})
end)
 = 0.3
_G.TargetX = 0
_G.TargetY = 0

local Window = Rayfield:CreateWindow({
   Name = "Supreme Farmer | Overdrive Edition",
   LoadingTitle = "Master Logic Initializing...",
   LoadingSubtitle = "by xaizeno17-cyber",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false 
})

-- [[ TAB UTAMA: AUTO-FARM ]] --
local TabFarm = Window:CreateTab("Auto-Farm", 4483345998)

TabFarm:CreateToggle({
   Name = "Enable Grid Auto-Farm",
   CurrentValue = false,
   Callback = function(Value)
      _G.FarmingActive = Value
      if _G.FarmingActive then
         spawn(function()
            -- Memastikan input terdeteksi game
            game:GetService("VirtualUser"):CaptureController()
            
            while _G.FarmingActive do
               pcall(function()
                  local Player = game.Players.LocalPlayer
                  local Character = Player.Character
                  local HRP = Character:FindFirstChild("HumanoidRootPart")
                  local Tool = Character:FindFirstChildOfClass("Tool")
                  
                  if HRP then
                     -- KALKULASI GRID PRESISI (Unit 5 = 1 Block)
                     local TargetPos = HRP.CFrame * CFrame.new(_G.TargetX * 5, _G.TargetY * 5, -5)
                     
                     -- CEK OBJEK (Raycast)
                     local RayParam = RaycastParams.new()
                     RayParam.FilterDescendantsInstances = {Character}
                     local Check = workspace:Raycast(HRP.Position, (TargetPos.Position - HRP.Position), RayParam)
                     
                     if Check and Check.Instance and Check.Instance:IsA("BasePart") then
                        -- TAHAP 1: BREAK (Pukul Blok yang Terdeteksi)
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                     else
                        -- TAHAP 2: PLACE (Gunakan Item Apapun di Tangan)
                        if Tool then
                           Tool:Activate()
                        else
                           -- Jika Tangan Kosong, Tetap Pukul (Punch)
                           game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
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

TabFarm:CreateSection("Farm Configuration")

TabFarm:CreateSlider({
   Name = "Kecepatan Memukul (Detik)",
   Min = 0.1,
   Max = 1,
   CurrentValue = 0.3,
   Callback = function(Value) _G.FarmSpeed = Value end,
})

TabFarm:CreateSlider({
   Name = "Range Grid X (Kiri -3 / Kanan 3)",
   Min = -3,
   Max = 3,
   CurrentValue = 0,
   Callback = function(Value) _G.TargetX = Value end,
})

TabFarm:CreateSlider({
   Name = "Range Grid Y (Bawah -3 / Atas 3)",
   Min = -3,
   Max = 3,
   CurrentValue = 0,
   Callback = function(Value) _G.TargetY = Value end,
})

-- Tombol Show UI Cadangan
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 80, 0, 30)
OpenBtn.Position = UDim2.new(0, 10, 0, 80)
OpenBtn.Text = "Show Menu"
OpenBtn.Draggable = true
OpenBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.MouseButton1Click:Connect(function()
    Rayfield:Notify({Title = "Hint", Content = "Tekan RCTRL untuk Toggle UI", Duration = 2})
end)
