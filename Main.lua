--[[ 
    SUPREME TABBED GUI v1.2 (WITH TOGGLE)
    Author: xaizeno17-cyber
    Description: Ringan, Tabbed, dan memiliki fitur Toggle untuk Mobile.
]]

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Hapus GUI lama agar tidak menumpuk
if CoreGui:FindFirstChild("SupremeTabMenu") then
    CoreGui.SupremeTabMenu:Destroy()
end

-- [MAIN UI ELEMENTS]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SupremeTabMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [TOGGLE BUTTON - Tombol Kecil untuk Buka/Tutup]
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.Text = "OPEN"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 10
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 50) -- Membuat jadi lingkaran
ToggleCorner.Parent = ToggleBtn

-- [MAIN FRAME]
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 220)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false -- Mulai dengan tertutup
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- [LOGIKA TOGGLE]
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    ToggleBtn.Text = MainFrame.Visible and "CLOSE" or "OPEN"
    ToggleBtn.BackgroundColor3 = MainFrame.Visible and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 40, 40)
end)

-- [SIDEBAR NAVIGATION]
local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 80, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 10)
SideCorner.Parent = SideBar

-- [TAB CONTAINER]
local TabContainer = Instance.new("Frame")
TabContainer.Position = UDim2.new(0, 90, 0, 10)
TabContainer.Size = UDim2.new(1, -100, 1, -20)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

-- Fungsi Pembuat Tab
local function CreateTab(name, pos)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, -10, 0, 35)
    TabBtn.Position = UDim2.new(0, 5, 0, pos)
    TabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.new(1, 1, 1)
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextSize = 12
    TabBtn.Parent = SideBar
    
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Size = UDim2.new(1, 0, 1, 0)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Visible = false
    ContentFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
    ContentFrame.ScrollBarThickness = 2
    ContentFrame.Parent = TabContainer
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(TabContainer:GetChildren()) do v.Visible = false end
        ContentFrame.Visible = true
    end)
    
    return ContentFrame
end

-- [ISI TAB]
local PlayerTab = CreateTab("Player", 10)
local MiscTab = CreateTab("Misc", 50)

PlayerTab.Visible = true -- Default Tab

-- Fitur Speed
local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(1, -10, 0, 40)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
SpeedBtn.Text = "Set Speed (100)"
SpeedBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedBtn.Font = Enum.Font.GothamBold
SpeedBtn.Parent = PlayerTab

SpeedBtn.MouseButton1Click:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 100
    end
end)

-- Fitur Jump
local JumpBtn = Instance.new("TextButton")
JumpBtn.Size = UDim2.new(1, -10, 0, 40)
JumpBtn.Position = UDim2.new(0, 0, 0, 50)
JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
JumpBtn.Text = "Set Jump (100)"
JumpBtn.TextColor3 = Color3.new(1, 1, 1)
JumpBtn.Font = Enum.Font.GothamBold
JumpBtn.Parent = PlayerTab

JumpBtn.MouseButton1Click:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = 100
        char.Humanoid.UseJumpPower = true
    end
end)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
