local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ DATABASE KOORDINAT ABSOLUT ]] --
_G.FarmConfig = {
    Enabled = false,
    X = 0,
    Y = 0,
    Speed = 0.3
}

local Window = Rayfield:CreateWindow({
   Name = "Supreme Farmer | Coordinate Mode",
   LoadingTitle = "Switching to Absolute Mapping...",
   LoadingSubtitle = "by xaizeno17-cyber",
   ConfigurationSaving = {Enabled = false}
})

local Tab = Window:CreateTab("Auto-Farm", 4483345998)

-- [[ FUNGSI UTAMA ]] --
Tab:CreateToggle({
   Name = "Aktifkan Auto-Farm Koordinat",
   CurrentValue = false,
   Callback = function(Value)
      _G.FarmConfig.Enabled = Value
      if Value then
         spawn(function()
            local VU = game:GetService("VirtualUser")
            while _G.FarmConfig.Enabled do
               pcall(function()
                  local Char = game.Players.LocalPlayer.Character
                  local Tool = Char:FindFirstChildOfClass("Tool")
                  
                  -- MENGUBAH INPUT KOORDINAT MENJADI POSISI DUNIA (WORLD POSITION)
                  -- Kita asumsikan titik 0,0 dunia berada di origin map
                  local TargetWorldPos = Vector3.new(_G.FarmConfig.X * 5, _G.FarmConfig.Y * 5, 0)
                  
                  -- Arahkan Kamera ke Koordinat Tujuan
                  workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, TargetWorldPos)
                  
                  -- CEK APAKAH ADA BLOK DI KOORDINAT TERSEBUT
                  local Region = Region3.new(TargetWorldPos - Vector3.new(2,2,2), TargetWorldPos + Vector3.new(2,2,2))
                  local Found = workspace:FindPartsInRegion3(Region, Char, 1)
                  
                  if #Found > 0 then
                     -- JIKA ADA BLOK -> PUKUL
                     VU:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                     task.wait(0.05)
                     VU:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                  else
                     -- JIKA KOSONG -> LETAKKAN ITEM
                     if Tool then
                        Tool:Activate()
                     end
                  end
               end)
               task.wait(_G.FarmConfig.Speed)
            end
         end)
      end
   end,
})

Tab:CreateSection("Input Koordinat Dunia")

-- INPUT KOORDINAT X (Bukan Slider, tapi Ketik Angka)
Tab:CreateInput({
   Name = "Masukkan Koordinat X",
   PlaceholderText = "Contoh: 100",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      _G.FarmConfig.X = tonumber(Text) or 0
   end,
})

-- INPUT KOORDINAT Y
Tab:CreateInput({
   Name = "Masukkan Koordinat Y",
   PlaceholderText = "Contoh: 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      _G.FarmConfig.Y = tonumber(Text) or 0
   end,
})

-- PENGATUR KECEPATAN (FIXED Tanpa Studs Bug)
Tab:CreateSlider({
   Name = "Jeda Waktu (Detik)",
   Min = 0.1,
   Max = 2,
   CurrentValue = 0.3,
   Callback = function(Value)
      _G.FarmConfig.Speed = Value
   end,
})
