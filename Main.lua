local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ VARIABEL GLOBAL ]] --
local FarmingActive = false
local FarmSpeed = 0.2
local TargetX = 0
local TargetY = 0

local Window = Rayfield:CreateWindow({
   Name = "Supreme Farmer | Craft a World",
   LoadingTitle = "Focusing on Farming Engine...",
   LoadingSubtitle = "by xaizeno17-cyber",
   ConfigurationSaving = {Enabled = true, FolderName = "SupremeUniversal"},
   KeySystem = false 
})

-- [[ TAB UTAMA: AUTO-FARM ]] --
local TabFarm = Window:CreateTab("Auto-Farm", 4483345998)

TabFarm:CreateToggle({
   Name = "Enable Grid Auto-Farm",
   CurrentValue = false,
   Callback = function(Value)
      FarmingActive = Value
      if FarmingActive then
         spawn(function()
            while FarmingActive do
               pcall(function()
                  local Player = game.Players.LocalPlayer
                  local Character = Player.Character
                  local HRP = Character:FindFirstChild("HumanoidRootPart")
                  local Tool = Character:FindFirstChildOfClass("Tool")
                  
                  if HRP and Tool then
                     -- KALKULASI GRID (Offset relatif terhadap karakter)
                     -- TargetX: Kiri(-)/Kanan(+), TargetY: Bawah(-)/Atas(+)
                     -- Pengali 5 unit disesuaikan dengan ukuran blok game
                     local TargetPos = HRP.CFrame * CFrame.new(TargetX * 5, TargetY * 5, -5)
                     
                     -- CEK OBJEK (Raycast dari karakter ke arah target grid)
                     local RayParam = RaycastParams.new()
                     RayParam.FilterDescendantsInstances = {Character}
                     local Check = workspace:Raycast(HRP.Position, (TargetPos.Position - HRP.Position), RayParam)
                     
                     if Check and Check.Instance and Check.Instance:IsA("BasePart") then
                        -- TAHAP 1: BREAK (Jika ada blok, kita pukul)
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                     else
                        -- TAHAP 2: PLACE (Jika kosong, kita letakkan item di tangan)
                        Tool:Activate()
                     end
                  elseif not Tool then
                     -- Jika tidak pegang item, sistem tetap mencoba memukul (Punch)
                     game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                  end
               end)
               task.wait(FarmSpeed)
            end
         end)
      end
   end,
})

TabFarm:CreateSection("Farm Configuration")

TabFarm:CreateSlider({
   Name = "Action Speed (Detik)",
   Min = 0.05,
   Max = 1,
   CurrentValue = 0.2,
   Callback = function(Value) FarmSpeed = Value end,
})

TabFarm:CreateSlider({
   Name = "Grid X (Kiri/Kanan)",
   Min = -3,
   Max = 3,
   CurrentValue = 0,
   Callback = function(Value) TargetX = Value end,
})

TabFarm:CreateSlider({
   Name = "Grid Y (Bawah/Atas)",
   Min = -3,
   Max = 3,
   CurrentValue = 0,
   Callback = function(Value) TargetY = Value end,
})

-- [[ TAB PENDUKUNG: KARAKTER ]] --
local TabChar = Window:CreateTab("Character", 4483345998)
TabChar:CreateInput({
   Name = "WalkSpeed Bypass",
   PlaceholderText = "Input 16-300",
   Callback = function(Text)
      local s = tonumber(Text)
      if s then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s end
   end,
})

-- Tombol Show UI di layar (Sesuai gambar Anda)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Name = "MasterOpen"
OpenBtn.Size = UDim2.new(0, 80, 0, 30)
OpenBtn.Position = UDim2.new(0, 10, 0, 80)
OpenBtn.Text = "Show Menu"
OpenBtn.Draggable = true
OpenBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.MouseButton1Click:Connect(function()
    Rayfield:Notify({Title = "Hint", Content = "Tekan RCTRL untuk Toggle UI", Duration = 2})
end)
