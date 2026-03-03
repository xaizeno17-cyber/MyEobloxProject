--[[ 
    SUPREME TABBED GUI v1.1
    Author: xaizeno17-cyber
    Description: Ringan, Modular, dan User-Friendly untuk Mobile
]]

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Hapus GUI lama jika ada agar tidak double
if CoreGui:FindFirstChild("SupremeTabMenu") then
    CoreGui.SupremeTabMenu:Destroy()
end

-- [MAIN UI ELEMENTS]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SupremeTabMenu"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 220)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Support Mobile Drag
MainFrame.Parent = ScreenGui

-- Membuat Sudut Bulat (Rounded Corner)
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- [SIDEBAR / TAB NAVIGATION]
local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 80, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 10)
SideCorner.Parent = SideBar

-- [TAB CONTAINER]
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Position = UDim2.new(0, 90, 0, 10)
TabContainer.Size = UDim2.new(1, -100, 1, -20)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

-- Fungsi Sederhana untuk Ganti Tab
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

-- [MEMBUAT TAB]
local PlayerTab = CreateTab("Player", 10)
local MiscTab = CreateTab("Misc", 50)

-- Default Tab yang terbuka
PlayerTab.Visible = true

-- [ISI TAB PLAYER]
local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(1, -10, 0, 40)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
SpeedBtn.Text = "Set Speed (100)"
SpeedBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedBtn.Parent = PlayerTab

SpeedBtn.MouseButton1Click:Connect(function()
    local Hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if Hum then Hum.WalkSpeed = 100 end
end)

-- [TOMBOL CLOSE]
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
