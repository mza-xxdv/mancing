-- Real-time koordinat player + tombol klik "COPY" (auto-follow bawah Z)
-- by bubb ❤️

local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")

-- text koordinat
local coordsText = Drawing.new("Text")
coordsText.Size = 12
coordsText.Color = Color3.fromRGB(0, 255, 0)
coordsText.Outline = true
coordsText.Center = false
coordsText.Visible = true
coordsText.Position = Vector2.new(20, 55)
coordsText.Font = 2

-- tombol copy
local copyBox = Drawing.new("Square")
copyBox.Size = Vector2.new(40, 15)
copyBox.Color = Color3.fromRGB(50, 50, 50)
copyBox.Filled = true
copyBox.Visible = true

local copyText = Drawing.new("Text")
copyText.Size = 8
copyText.Color = Color3.fromRGB(255, 255, 255)
copyText.Center = true
copyText.Outline = true
copyText.Text = "COPY"
copyText.Visible = true
copyText.Font = 1

-- ambil root part
local function getRoot()
	local char = player.Character
	if not char then return end
	return char:FindFirstChild("HumanoidRootPart")
end

-- update posisi dan tombol tiap frame
runService.RenderStepped:Connect(function()
	local root = getRoot()
	if root then
		local pos = root.Position
		coordsText.Text = string.format("X: %.2f\nY: %.2f\nZ: %.2f", pos.X, pos.Y, pos.Z)

		-- posisikan tombol di bawah teks Z
		local textHeight = coordsText.Size * 2.6 -- kira-kira 3 baris teks
		local baseY = coordsText.Position.Y + textHeight + 5
		copyBox.Position = Vector2.new(coordsText.Position.X, baseY)
		copyText.Position = Vector2.new(copyBox.Position.X + copyBox.Size.X / 2, baseY + 4)
	else
		coordsText.Text = "Character belum terload..."
	end
end)

-- fungsi copy koordinat
local function copyCoords()
	local root = getRoot()
	if not root then return end
	local pos = root.Position
	local text = string.format("%.2f,%.2f,%.2f", pos.X, pos.Y, pos.Z)
	setclipboard(text)
	coordsText.Color = Color3.fromRGB(255, 255, 0)
	coordsText.Text = "📋 Copied: " .. text
	task.wait(0.7)
	coordsText.Color = Color3.fromRGB(0, 255, 0)
end

-- deteksi klik tombol
userInput.InputBegan:Connect(function(input, gp)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		local mouse = userInput:GetMouseLocation()
		local x, y = mouse.X, mouse.Y
		if x > copyBox.Position.X and x < copyBox.Position.X + copyBox.Size.X and
			y > copyBox.Position.Y and y < copyBox.Position.Y + copyBox.Size.Y then
			pcall(copyCoords)
		end
	end
end)

-- 💾 Save & Teleport Toggle GUI (posisi tidak auto-teleport saat respawn)
-- by bubb ❤️

local player = game:GetService("Players").LocalPlayer

-- posisi global (tidak hilang walau respawn)
getgenv().savedPos = getgenv().savedPos or nil

-- buat GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BubbToggleGui"
screenGui.Parent = game.CoreGui

-- fungsi buat tombol
local function createButton(name, text, posY)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Parent = screenGui
	btn.Text = text
	btn.Size = UDim2.new(0, 80, 0, 25)
	btn.Position = UDim2.new(0, 20, 0.26 + posY, 0)
	btn.AnchorPoint = Vector2.new(0, 0.5)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BorderSizePixel = 0
	btn.TextSize = 10
	btn.Font = Enum.Font.GothamBold
	btn.BackgroundTransparency = 0.1
	btn.Active = true
	btn.Draggable = true
	return btn
end

-- tombol
local saveBtn = createButton("SavePosBtn", "💾 Save Posisi", -0.05)
local tpBtn = createButton("TpBtn", "⚡ Teleport", 0.05)

-- ambil HumanoidRootPart dengan aman
local function getHRP()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("HumanoidRootPart", 10)
end

-- simpan posisi
saveBtn.MouseButton1Click:Connect(function()
	local hrp = getHRP()
	if hrp then
		getgenv().savedPos = hrp.Position
		game.StarterGui:SetCore("SendNotification", {
			Title = "Posisi Disimpan 💾",
			Text = string.format("X: %.2f | Y: %.2f | Z: %.2f", getgenv().savedPos.X, getgenv().savedPos.Y, getgenv().savedPos.Z),
			Duration = 3
		})
	end
end)

-- teleport manual
tpBtn.MouseButton1Click:Connect(function()
	local hrp = getHRP()
	if getgenv().savedPos and hrp then
		hrp.CFrame = CFrame.new(getgenv().savedPos)
		game.StarterGui:SetCore("SendNotification", {
			Title = "Teleport ⚡",
			Text = "Kembali ke posisi tersimpan 😎",
			Duration = 2
		})
	else
		game.StarterGui:SetCore("SendNotification", {
			Title = "Belum ada posisi 😢",
			Text = "Tekan Save dulu ya sayang 💋",
			Duration = 2
		})
	end
end)

-- tetap simpan posisi walau respawn, tapi tidak auto teleport
player.CharacterAdded:Connect(function(char)
	char:WaitForChild("HumanoidRootPart", 10)
	if getgenv().savedPos then
		game.StarterGui:SetCore("SendNotification", {
			Title = "Posisi Masih Tersimpan 💾",
			Text = "Kamu respawn, tapi data posisi aman 😘",
			Duration = 3
		})
	end
end)


-- 🔁 Rejoin Server (Delta compatible)
-- by bubb ❤️

local player = game:GetService("Players").LocalPlayer
local TeleportService = game:GetService("TeleportService")

-- buat GUI tombol di kiri bawah
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BubbRejoinGui"
screenGui.Parent = game.CoreGui

local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Parent = screenGui
rejoinBtn.Size = UDim2.new(0, 80, 0, 20)
rejoinBtn.Position = UDim2.new(0, 20, 1, -170)
rejoinBtn.AnchorPoint = Vector2.new(0, 1)
rejoinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinBtn.Text = "🔁 Rejoin Server"
rejoinBtn.Font = Enum.Font.GothamBold
rejoinBtn.TextSize = 10
rejoinBtn.BorderSizePixel = 0
rejoinBtn.BackgroundTransparency = 0.1
rejoinBtn.Active = true
rejoinBtn.Draggable = true

-- fungsi rejoin
rejoinBtn.MouseButton1Click:Connect(function()
	local success, err = pcall(function()
		local gameId = game.PlaceId
		local jobId = game.JobId
		game:GetService("TeleportService"):TeleportToPlaceInstance(gameId, jobId, player)
	end)
	if not success then
		game:GetService("TeleportService"):Teleport(game.PlaceId, player)
	end
end)

-- notif kecil
game.StarterGui:SetCore("SendNotification", {
	Title = "Rejoin GUI aktif 💫";
	Text = "Klik tombol 🔁 di kiri bawah buat rejoin server yang sama.";
	Duration = 5;
})





-- 🔁 Rejoin Random Server (Delta compatible)
-- by bubb ❤️

local player = game:GetService("Players").LocalPlayer
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- buat GUI tombol di kiri bawah
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BubbRejoinRandomGui"
screenGui.Parent = game.CoreGui

local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Parent = screenGui
rejoinBtn.Size = UDim2.new(0, 100, 0, 20)
rejoinBtn.Position = UDim2.new(0, 20, 1, -140)
rejoinBtn.AnchorPoint = Vector2.new(0, 1)
rejoinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinBtn.Text = "🔁 Random Server"
rejoinBtn.Font = Enum.Font.GothamBold
rejoinBtn.TextSize = 10
rejoinBtn.BorderSizePixel = 0
rejoinBtn.BackgroundTransparency = 0.1
rejoinBtn.Active = true
rejoinBtn.Draggable = true

-- 🔍 Cari server dengan jumlah pemain terbanyak (belum penuh)
local function getMostPopulatedServer()
    local HttpService = game:GetService("HttpService")
    local servers = {}
    local cursor = nil
    local bestServer = nil
    local maxPlayersCount = 0

    -- ambil daftar server, bisa beberapa halaman
    repeat
        local url = string.format(
            "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100%s",
            game.PlaceId,
            cursor and "&cursor=" .. cursor or ""
        )

        local success, response = pcall(function()
            return game:HttpGet(url)
        end)

        if success and response then
            local data = HttpService:JSONDecode(response)
            if data and data.data then
                for _, server in ipairs(data.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        if server.playing > maxPlayersCount then
                            maxPlayersCount = server.playing
                            bestServer = server.id
                        end
                    end
                end
            end
            cursor = data.nextPageCursor
        else
            cursor = nil
        end
        task.wait(0.2)
    until not cursor

    return bestServer
end


-- klik tombol → teleport ke random server
rejoinBtn.MouseButton1Click:Connect(function()
	local serverId = getRandomServer()
	if serverId then
		TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, player)
	else
		TeleportService:Teleport(game.PlaceId, player)
	end
end)

-- notif aktif
game.StarterGui:SetCore("SendNotification", {
	Title = "Rejoin GUI aktif 💫",
	Text = "Klik 🔁 Random Server buat pindah ke server lain.",
	Duration = 5,
})



-- ♻️ Respawn + Teleport ke posisi terakhir sebelum respawn (Delay 3 detik)
-- by bubb ❤️

local player = game:GetService("Players").LocalPlayer

-- buat GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BubbRespawnLastPosGui"
screenGui.Parent = game.CoreGui

-- fungsi buat tombol
local function createButton(name, text, posY)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Parent = screenGui
	btn.Text = text
	btn.Size = UDim2.new(0, 120, 0, 25)
	btn.Position = UDim2.new(0, 20, posY, 50)
	btn.AnchorPoint = Vector2.new(0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BorderSizePixel = 0
	btn.TextSize = 12
	btn.Font = Enum.Font.GothamBold
	btn.BackgroundTransparency = 0.1
	btn.Active = true
	btn.Draggable = true
	return btn
end

-- tombol utama
local respawnBtn = createButton("RespawnTeleportBtn", "⚡ Respawn", 0.4)

-- ambil HumanoidRootPart
local function getHRP()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("HumanoidRootPart", 10)
end

-- klik tombol → respawn + teleport ke posisi terakhir
respawnBtn.MouseButton1Click:Connect(function()
	local hrp = getHRP()
	if not hrp then return end

	-- simpan posisi terakhir sebelum respawn
	local lastPos = hrp.Position

	-- respawn karakter
	local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Health = 0
	end

	-- tunggu respawn selesai
	player.CharacterAdded:Wait()
	task.wait(3) -- delay 3 detik biar render selesai

	local newHRP
	repeat
		task.wait(0.3)
		newHRP = getHRP()
	until newHRP

	-- teleport ke posisi terakhir sebelum respawn
	newHRP.CFrame = CFrame.new(lastPos)
end)
