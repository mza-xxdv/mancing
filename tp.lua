-- Gui Teleport & View (Delta Executor)
-- JUDUL: Gunung Sibuatan (Versi Simple Drag + Minimize)

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Header = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local MinBtn = Instance.new("TextButton")
local Content = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MainFrame
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Position = UDim2.new(0,20,1,-300) -- pojok kiri bawah
MainFrame.Size = UDim2.new(0,420,0,300)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,8)

-- Header (sama warna dengan body, hitam transparan)
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(30,30,30)
Header.BackgroundTransparency = 0.25
Header.Size = UDim2.new(1,0,0,30)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0,8)

Title.Parent = Header
Title.Text = "Fish IT"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Position = UDim2.new(0,10,0,0)
Title.Size = UDim2.new(0.7,0,1,0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Close
CloseBtn.Parent = Header
CloseBtn.Size = UDim2.new(0,30,1,0)
CloseBtn.Position = UDim2.new(1,-30,0,0)
CloseBtn.Text = "X"
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.Font = Enum.Font.GothamBold

-- Tombol Minimize
MinBtn.Parent = Header
MinBtn.Size = UDim2.new(0,30,1,0)
MinBtn.Position = UDim2.new(1,-60,0,0)
MinBtn.Text = "-"
MinBtn.BackgroundTransparency = 1
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.Font = Enum.Font.GothamBold

-- Content (ScrollingFrame tabel)
Content.Parent = MainFrame
Content.Position = UDim2.new(0,0,0,30)
Content.Size = UDim2.new(1,0,1,-30)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 6
Content.CanvasSize = UDim2.new(0,0,0,0)
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.ScrollBarImageColor3 = Color3.fromRGB(150,150,150)

UIListLayout.Parent = Content
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0,1)

-- Data Lokasi
local locations = {
    {name="Fisherman Island", pos=Vector3.new(128.62,3.53,2783.18)},
    {name="Kohana", pos=Vector3.new(-706.47,3.04,795.74)},
    {name="Kohana Volcano", pos=Vector3.new(-628.88,55.46,198.71)},
    {name="Coral Reffs", pos=Vector3.new(-3233.17,11.16,2133.76)},
    {name="Esoteric Island", pos=Vector3.new(1992.28,7.58,1370.75)},
    {name="Esoteric Deepths", pos=Vector3.new(3031.82,-1302.73,1495.54)},
    {name="Enchant Altar", pos=Vector3.new(3234.54,-1302.85,1399.92)},
    {name="Tropical Grove", pos=Vector3.new(-2092.90,6.27,3693.93)},
    {name="Creater Island", pos=Vector3.new(979.85,47.12,5085.67)},
    {name="Treasure Room", pos=Vector3.new(-3599.35,-266.37,-1582.00)},
    {name="Sisyphus Statue", pos=Vector3.new(-3715.52,-135.07,-1015.71)},
    {name="Acient Jungle", pos=Vector3.new(1509.61,25.61,-297.77)},
    {name="Sacred Temple", pos=Vector3.new(1447.84,-22.13,-633.20)},
    {name="Underground Cellar", pos=Vector3.new(2121.51,-91.20,-698.89)},
    {name="Ice Island", pos=Vector3.new(2155.03,6.55,3291.96)},
    {name="Weather Machine", pos=Vector3.new(-1495.25,6.50,1889.92)},
}



local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local function teleportTo(position)
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- View toggle
local isViewing = false
local viewConn = nil
local currentViewBtn = nil
local function toggleView(position, button)
    local cam = workspace.CurrentCamera
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local speed = 2

    if not isViewing then
        isViewing = true
        currentViewBtn = button
        button.TextColor3 = Color3.fromRGB(0,200,0)

        cam.CameraType = Enum.CameraType.Scriptable
        cam.CFrame = CFrame.new(position + Vector3.new(0,5,0)) * CFrame.Angles(0,math.rad(180),0)

        viewConn = RunService.RenderStepped:Connect(function()
            local moveVec = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.E) then moveVec = moveVec + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.Q) then moveVec = moveVec - Vector3.new(0,1,0) end
            cam.CFrame = cam.CFrame + moveVec * speed
        end)
    else
        isViewing = false
        if viewConn then viewConn:Disconnect() end
        cam.CameraType = Enum.CameraType.Custom
        cam.CameraSubject = LP.Character:FindFirstChild("Humanoid")
        if currentViewBtn then
            currentViewBtn.TextColor3 = Color3.fromRGB(255,255,255)
            currentViewBtn = nil
        end
    end
end

-- Generate tabel row
for _,loc in ipairs(locations) do
    local row = Instance.new("Frame", Content)
    row.Size = UDim2.new(1,0,0,28)
    row.BackgroundTransparency = 1

    local line = Instance.new("Frame", row)
    line.Size = UDim2.new(1,0,0,1)
    line.Position = UDim2.new(0,0,1,-1)
    line.BackgroundColor3 = Color3.fromRGB(60,60,60)

    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(0.4,0,1,0)
    label.Text = loc.name
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Position = UDim2.new(0,10,0,0)

    local tpBtn = Instance.new("TextButton", row)
    tpBtn.Size = UDim2.new(0,70,0.8,0)
    tpBtn.Position = UDim2.new(0.55,0,0.1,0)
    tpBtn.Text = "Teleport"
    tpBtn.Font = Enum.Font.Gotham
    tpBtn.TextSize = 13
    tpBtn.BackgroundTransparency = 1
    tpBtn.TextColor3 = Color3.fromRGB(100,180,255)

    local viewBtn = Instance.new("TextButton", row)
    viewBtn.Size = UDim2.new(0,60,0.8,0)
    viewBtn.Position = UDim2.new(0.8,0,0.1,0)
    viewBtn.Text = "View"
    viewBtn.Font = Enum.Font.Gotham
    viewBtn.TextSize = 13
    viewBtn.BackgroundTransparency = 1
    viewBtn.TextColor3 = Color3.fromRGB(200,200,200)

    tpBtn.MouseButton1Click:Connect(function()
        teleportTo(loc.pos)
    end)
    viewBtn.MouseButton1Click:Connect(function()
        toggleView(loc.pos, viewBtn)
    end)
end

-- Close
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Minimize
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Content.Visible = false
        MainFrame.Size = UDim2.new(0,420,0,30)
    else
        Content.Visible = true
        MainFrame.Size = UDim2.new(0,420,0,300)
    end
end)

-- Dragging (PC & Mobile)
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
