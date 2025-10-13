-- 🟢 One-Click Circle Sell Button (Auto Click Tiap 2 Jam + Draggable + Persistent + Centered)
-- by bubb ❤️

local player = game.Players.LocalPlayer

-- Ambil event network sell
local function getSellEvent()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local success, result = pcall(function()
        local net = replicatedStorage:WaitForChild("Packages")
            :WaitForChild("_Index")
            :WaitForChild("sleitnick_net@0.2.0")
            :WaitForChild("net")
        return net:WaitForChild("RF/SellAllItems")
    end)
    return success and result or nil
end

local sellEvent = getSellEvent()

-- Fungsi jual sekali klik
local function sellOnce()
    if sellEvent then
        pcall(function()
            sellEvent:InvokeServer()
        end)
        print("💰 Semua ikan sudah dijual!")
    else
        warn("❌ Sell event tidak ditemukan.")
    end
end

-- 🖥️ Buat UI Lingkaran Draggable
local function createUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "SellCircleUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = player:WaitForChild("PlayerGui")

    local button = Instance.new("TextButton")
    button.Parent = gui
    button.Size = UDim2.new(0, 25, 0, 25)
    button.Position = UDim2.new(0.5, -25, 0.5, -25)
    button.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    button.Text = "💰"
    button.TextScaled = true
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.BorderSizePixel = 0
    button.Active = true

    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(1, 0)

    -- efek klik manual
    button.MouseButton1Click:Connect(function()
        sellOnce()
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
        task.delay(0.2, function()
            button.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        end)
    end)

    -- sistem drag
    local UIS = game:GetService("UserInputService")
    local dragging, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        button.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = button.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)

    -- 🔁 Auto Click Loop tiap 2 jam (7200 detik)
    task.spawn(function()
        while true do
            task.wait(7200) -- 2 jam
            if button and button.Parent then
                sellOnce()
                -- flash efek tombol
                button.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
                task.delay(0.2, function()
                    button.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
                end)
            end
        end
    end)
end

-- Buat UI pertama kali
createUI()

-- Bikin lagi kalau respawn
player.CharacterAdded:Connect(function()
    task.wait(1)
    if not player.PlayerGui:FindFirstChild("SellCircleUI") then
        createUI()
    end
end)
