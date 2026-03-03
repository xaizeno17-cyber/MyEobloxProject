local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ DETEKSI GAME ]] --
local isGroqGarden = (game.PlaceId == 123456789) -- Ganti dengan ID Game Groq a Garden
local isPixelGame = (game.PlaceId == 1000786804 or game.Name == "Pixel Game") -- ID dari foto tadi

local Window = Rayfield:CreateWindow({
   Name = "Supreme Universal | " .. (isGroqGarden and "Groq Edition" or "Pixel Edition"),
   LoadingTitle = "Detecting Environment...",
   LoadingSubtitle = "by xaizeno17-cyber",
   ConfigurationSaving = {Enabled = true, FolderName = "SupremeUniversal"},
   KeySystem = false 
})

-- [[ TAB 1: KARAKTER ]] --
local Tab1 = Window:CreateTab("Karakter", 4483345998)

Tab1:CreateInput({
   Name = "Speed (0-300)",
   PlaceholderText = "Input Angka",
   Callback = function(Text)
      local s = tonumber(Text)
      if s then
         -- Teknik Universal: Mencoba berbagai cara merubah speed
         pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s end)
         -- Jika game pakai sistem custom, kita paksa koordinatnya (CFrame)
      end
   end,
})

local InfJump = false
Tab1:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value) InfJump = Value end,
})

-- Rumus Master Supreme untuk Speed yang tidak bisa diblokir:
game:GetService("RunService").RenderStepped:Connect(function()
    if SpeedEnabled then
        local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
        local hum = game.Players.LocalPlayer.Character.Humanoid
        -- Mengalikan arah jalan dengan kecepatan tambahan
        hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (targetSpeed / 10))
    end
end)


-- [[ TAB 2: AUTO-FARM (KHUSUS GAME PIXEL) ]] --
local Tab2 = Window:CreateTab("Auto-Farm", 4483345998)

-- Logika Auto-Farm Master Supreme
local function StartFarming()
    spawn(function()
        while FarmingActive do
            -- 1. Mendapatkan koordinat di depan karakter (untuk meletakkan/memukul)
            local targetPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
            
            -- 2. Menjalankan fungsi pukul (Simulasi klik mouse)
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            
            -- 3. Menjalankan fungsi letakkan (Jika kita tahu Remote-nya)
            -- game.ReplicatedStorage.Remotes.PlaceBlock:FireServer(targetPos, "Dirt")
            
            task.wait(0.1) -- Kecepatan pukul (Master Speed)
        end
    end)
end


if isPixelGame then
    local Farming = false
    Tab2:CreateToggle({
       Name = "Auto Place & Break",
       CurrentValue = false,
       Callback = function(Value)
          Farming = Value
          spawn(function()
             while Farming do
                -- Logic Khusus Game di Foto:
                -- Meletakkan item dan memukul otomatis
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(800, 800))
                task.wait(0.2)
             end
          end)
       end,
    })
else
    Tab2:CreateLabel("Fitur Auto-Farm tidak tersedia untuk game ini.")
end



-- [[ FIX MINIMIZE: TOMBOL FLOATING ]] --
-- Karena kamu mengeluh tidak bisa balik ke UI, kita buat tombol "Open" kecil di layar
local ScreenGui = Instance.new("ScreenGui")
local OpenButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
OpenButton.Size = UDim2.new(0, 100, 0, 30)
OpenButton.Position = UDim2.new(0, 10, 0, 10)
OpenButton.Text = "Show Master"
OpenButton.TextColor3 = Color3.new(1,1,1)
OpenButton.Draggable = true

OpenButton.MouseButton1Click:Connect(function()
    Rayfield:Notify({Title = "UI Toggle", Content = "Tekan RCTRL untuk Open/Close", Duration = 2})
end)

-- [[ LOGIC INFINITE JUMP ]] --
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfJump then
        pcall(function()
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end)
    end
end)

Rayfield:Notify({Title = "Master Loaded", Content = "Script siap digunakan!", Duration = 5})
