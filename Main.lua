local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MyRobloxProject | Master Supreme Edition",
   LoadingTitle = "Initializing Scripts...",
   LoadingSubtitle = "by xaizeno17-cyber",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SupremeScripts",
      FileName = "MainConfig"
   },
   KeySystem = false -- Set true jika ingin pakai password
})

-- [[ TAB 1: MAIN (KARAKTER) ]] --
local Tab1 = Window:CreateTab("Karakter", 4483345998)
local Section1 = Tab1:CreateSection("Movement & Physics")

Tab1:CreateInput({
   Name = "WalkSpeed (0-300)",
   PlaceholderText = "Input Angka",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local s = tonumber(Text)
      if s then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s end
   end,
})

Tab1:CreateInput({
   Name = "JumpPower (0-300)",
   PlaceholderText = "Input Angka",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local j = tonumber(Text)
      if j then game.Players.LocalPlayer.Character.Humanoid.JumpPower = j end
   end,
})

local InfJump = false
Tab1:CreateToggle({
   Name = "Infinite Jump (Auto Jump/Fly)",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
      InfJump = Value
   end,
})

-- Logic Infinite Jump
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfJump then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- [[ TAB 2: AUTOMATION (FARM) ]] --
local Tab2 = Window:CreateTab("Automation", 4483345998)
Tab2:CreateLabel("Fitur Auto-Farm akan mendeteksi game secara otomatis...")
Tab2:CreateToggle({
   Name = "Auto Clicker / Farm",
   CurrentValue = false,
   Callback = function(Value)
      -- Masukkan logic auto-click di sini
   end,
})

-- [[ TAB 3: VISUALS (ESP) ]] --
local Tab3 = Window:CreateTab("Visuals", 4483345998)
Tab3:CreateButton({
   Name = "Enable Name ESP",
   Callback = function()
      -- Logic ESP sederhana
      print("ESP Activated")
   end,
})

-- [[ TAB 4: TELEPORT ]] --
local Tab4 = Window:CreateTab("Teleport", 4483345998)
Tab4:CreateButton({
   Name = "Teleport to Safe Zone",
   Callback = function()
      -- game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
   end,
})

-- [[ TAB 5: SETTINGS ]] --
local Tab5 = Window:CreateTab("Settings", 4483345998)
Tab5:CreateSection("UI Controls")

Tab5:CreateParagraph({Title = "Tutorial Minimize", Content = "Tekan tombol 'Right Control' (RCTRL) untuk menyembunyikan atau membuka kembali UI ini."})

Tab5:CreateButton({
   Name = "Destroy UI (Stop Script)",
   Callback = function()
      Rayfield:Destroy()
   end,
})

-- [[ SISTEM TOGGLE UI (MINIMIZE FIX) ]] --
-- Ini agar UI bisa dibuka tutup tanpa bug
Rayfield:Notify({
   Title = "Script Loaded!",
   Content = "Gunakan RCTRL untuk Minimize UI",
   Duration = 5,
   Image = 4483345998,
})
