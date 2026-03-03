-- [[ XAIZEN-CYBER - SUPREME LOADER V.1.0 ]] --
getgenv().XaizenVersion = "1.0.0"
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TS = game:GetService("TweenService")
local LP = Players.LocalPlayer

-- [[ PROTEKSI MASTER XAIZEN ]] --
pcall(function()
    if getgenv().XaizenUI then
        getgenv().XaizenUI:Destroy()
    end
end)

-- [[ SETUP UI UTAMA ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XaizenCyberIndex"
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LP.PlayerGui end
ScreenGui.ResetOnSpawn = false
getgenv().XaizenUI = ScreenGui

-- Skema Warna Xaizen (Deep Dark & Cyber Purple)
local Theme = {
    Bg = Color3.fromRGB(15, 15, 20),
    Header = Color3.fromRGB(10, 10, 12),
    Item = Color3.fromRGB(25, 25, 30),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(180, 180, 180),
    Purple = Color3.fromRGB(140, 80, 255), -- Warna Identitas Xaizen
    Accent = Color3.fromRGB(100, 60, 200)
}

-- Tombol Logo Xaizen (Minimized)
local XBtn = Instance.new("TextButton", ScreenGui)
XBtn.BackgroundColor3 = Theme.Bg
XBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
XBtn.Size = UDim2.new(0, 55, 0, 55)
XBtn.Text = "XZN"
XBtn.TextColor3 = Theme.Purple
XBtn.Font = Enum.Font.GothamBlack
XBtn.TextSize = 18
XBtn.Visible = false
Instance.new("UICorner", XBtn).CornerRadius = UDim.new(1, 0)
local XStroke = Instance.new("UIStroke", XBtn)
XStroke.Color = Theme.Purple
XStroke.Thickness = 2

-- Frame Utama
local Main = Instance.new("Frame", ScreenGui)
Main.BackgroundColor3 = Theme.Bg
Main.Position = UDim2.new(0.5, -275, 0.5, -170)
Main.Size = UDim2.new(0, 550, 0, 340)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Theme.Purple
MainStroke.Thickness = 1.5

-- Fungsi Drag Xaizen
local function MakeDraggable(frame, trigger)
    local dragging, dragInput, dragStart, startPos
    trigger.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end
MakeDraggable(Main, Main); MakeDraggable(XBtn, XBtn)

-- Header Xaizen-Cyber
local Header = Instance.new("Frame", Main)
Header.BackgroundColor3 = Theme.Header
Header.Size = UDim2.new(1, 0, 0, 50)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Header)
Title.Text = "XAIZEN-CYBER"
Title.TextColor3 = Theme.Text
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Close/Minimize
local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 35, 0, 30)
MinBtn.Position = UDim2.new(1, -50, 0.5, -15)
MinBtn.Text = "—"
MinBtn.BackgroundColor3 = Theme.Item
MinBtn.TextColor3 = Theme.Text
MinBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local function ToggleUI()
    Main.Visible = not Main.Visible
    XBtn.Visible = not Main.Visible
end
MinBtn.MouseButton1Click:Connect(ToggleUI)
XBtn.MouseButton1Click:Connect(ToggleUI)

-- [[ SISTEM TAB MODULES ]] --
local TabContainer = Instance.new("ScrollingFrame", Main)
TabContainer.Size = UDim2.new(0, 150, 1, -50)
TabContainer.Position = UDim2.new(0, 0, 0, 50)
TabContainer.BackgroundColor3 = Theme.Header
TabContainer.BorderSizePixel = 0
TabContainer.ScrollBarThickness = 0

local TabListLayout = Instance.new("UIListLayout", TabContainer)
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local PageContainer = Instance.new("Frame", Main)
PageContainer.Size = UDim2.new(1, -170, 1, -70)
PageContainer.Position = UDim2.new(0, 160, 0, 60)
PageContainer.BackgroundTransparency = 1

local Tabs = {}; local Pages = {}

local function CreateXaizenTab(Name, Desc, Link)
    local TBtn = Instance.new("TextButton", TabContainer)
    TBtn.Size = UDim2.new(0.9, 0, 0, 40)
    TBtn.BackgroundColor3 = Theme.Item
    TBtn.Text = Name
    TBtn.TextColor3 = Theme.SubText
    TBtn.Font = Enum.Font.GothamMedium
    Instance.new("UICorner", TBtn).CornerRadius = UDim.new(0, 8)

    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2

    local Status = Instance.new("TextLabel", Page)
    Status.Size = UDim2.new(1, 0, 0, 50)
    Status.Text = "Module: " .. Name .. "\nStatus: Menunggu eksekusi..."
    Status.TextColor3 = Theme.SubText
    Status.BackgroundTransparency = 1
    Status.Font = Enum.Font.Gotham

    local loaded = false
    TBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, t in pairs(Tabs) do t.BackgroundColor3 = Theme.Item end
        Page.Visible = true
        TBtn.BackgroundColor3 = Theme.Purple
        
        if not loaded and Link ~= "" then
            Status.Text = "⚡ Mengambil data dari server Xaizen..."
            task.spawn(function()
                local code = game:HttpGet(Link)
                local func = loadstring(code)
                if func then
                    Status.Text = "✅ Module Loaded Successfully"
                    func(Page)
                    loaded = true
                    task.wait(2)
                    Status:Destroy()
                else
                    Status.Text = "❌ Gagal memuat script!"
                end
            end)
        end
    end)
    table.insert(Tabs, TBtn); table.insert(Pages, Page)
end

-- [[ INJEKSI MODULE KOZIZ & XAIZEN ]] --
CreateXaizenTab("Pabrik", "Sistem otomatisasi pabrik (Koziz Engine).", "https://raw.githubusercontent.com/Koziz/CAW-SCRIPT/refs/heads/main/Pabrik.lua")
CreateXaizenTab("Auto Farm", "Farming Resource Kayu & Batu.", "https://raw.githubusercontent.com/Koziz/CAW-SCRIPT/refs/heads/main/Autofarm.lua")
CreateXaizenTab("Clear Area", "Membersihkan lahan secara otomatis.", "https://raw.githubusercontent.com/ZonHUBs/ZONHUB/refs/heads/main/autoclear.lua")
CreateXaizenTab("Manager", "Sortir dan kelola inventory.", "https://raw.githubusercontent.com/ZonHUBs/ZONHUB/refs/heads/main/manager.lua")
CreateXaizenTab("Chat Box", "Auto message system.", "https://raw.githubusercontent.com/ZonHUBs/ZONHUB/refs/heads/main/autochat.lua")

Rayfield:Notify({Title = "Xaizen-Cyber Loaded", Content = "Sistem telah diamankan dan siap digunakan.", Duration = 5})
