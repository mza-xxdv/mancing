

-- ====== SCRIPT INITIALIZATION SAFETY CHECK ======

-- Critical dependency validation
local success, errorMsg = pcall(function()
    -- Validate critical services
    local services = {
        game = game,
        workspace = workspace,
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        ReplicatedStorage = game:GetService("ReplicatedStorage"),
        HttpService = game:GetService("HttpService")
    }

    for serviceName, service in pairs(services) do
        if not service then
            error("Critical service missing: " .. serviceName)
        end
    end

    -- Validate LocalPlayer
    local LocalPlayer = game:GetService("Players").LocalPlayer
    if not LocalPlayer then
        error("LocalPlayer not available")
    end

    return true
end)

if not success then
    error("❌ [Auto Fish] Critical dependency check failed: " .. tostring(errorMsg))
    return
end

-- ====== ERROR HANDLING SETUP ======
-- Suppress asset loading errors (like sound approval issues)
local function suppressAssetErrors()
    local oldWarn = warn
    local oldError = error

    warn = function(...)
        local message = tostring(...)
        if string.find(message:lower(), "asset is not approved") or
           string.find(message:lower(), "failed to load sound") or
           string.find(message:lower(), "rbxassetid") then
            return
        end
        oldWarn(...)
    end

    error = function(...)
        local message = tostring(...)
        if string.find(message:lower(), "asset is not approved") or
           string.find(message:lower(), "failed to load sound") then
            warn("[Auto Fish] Asset loading error suppressed: " .. message)
            return
        end
        oldError(...)
    end
end

-- Apply error suppression
local suppressSuccess = pcall(suppressAssetErrors)
if not suppressSuccess then
    warn("⚠️ [Auto Fish] Error suppression setup failed")
end

-- ====== V3.3 MAXIMUM VRAM OPTIMIZATION ======
-- This version includes aggressive 3D rendering optimization to minimize VRAM usage

local RunService = game:GetService("RunService")

-- ====== AUTOMATIC PERFORMANCE OPTIMIZATION ======
local function ultimatePerformance()
    local workspace = game:GetService("Workspace")
    local lighting = game:GetService("Lighting")

    print("[VRAM Optimizer] 🚀 Starting ultimate performance mode...")

    pcall(function()
        local terrain = workspace:FindFirstChild("Terrain")
        if terrain then
            -- 3. delete children nya saja (from read.lua)
            local clouds = terrain:FindFirstChild("Clouds")
            if clouds then
                clouds:ClearAllChildren()
            end
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 0
            print("[VRAM Optimizer] ✅ Terrain optimized")
        end

        lighting.GlobalShadows = false
        lighting.FogEnd = 9e9
        lighting.Brightness = 0
        lighting.Technology = Enum.Technology.Compatibility
        -- 6. delete seluruh children nya (from read.lua)
        lighting:ClearAllChildren()
        print("[VRAM Optimizer] ✅ Lighting optimized")
    end)
end

-- ====== NEW: MAXIMUM VRAM OPTIMIZATION FUNCTIONS ======

-- Function to disable 3D rendering completely (MASSIVE VRAM SAVE)
local function disable3DRendering()
    pcall(function()
        RunService:Set3dRenderingEnabled(false)
        print("[VRAM Optimizer] ✅ 3D Rendering DISABLED - Maximum VRAM saving active!")
    end)
end

-- Function to enable 3D rendering (for restore)
local function enable3DRendering()
    pcall(function()
        RunService:Set3dRenderingEnabled(true)
        print("[VRAM Optimizer] 🔄 3D Rendering ENABLED")
    end)
end

-- Function to destroy all 3D objects in workspace (except essential fishing objects)
local function destroyWorkspace3DObjects()
    print("[VRAM Optimizer] 🗑️ Destroying non-essential 3D objects...")

    pcall(function()
        local workspace = game:GetService("Workspace")
        local objectsDestroyed = 0

        -- Whitelist of objects to keep (essential for fishing mechanics)
        local keepObjects = {
            ["Locations"] = true,
            ["NPCs"] = true,
            ["Teleports"] = true,
            ["!! ZONES"] = true,
            ["!!! MENU RINGS"] = true,
            ["Terrain"] = true,
        }

        -- Destroy all non-essential children
        for _, child in ipairs(workspace:GetChildren()) do
            local shouldKeep = keepObjects[child.Name]

            -- Keep LocalPlayer's character
            if child:IsA("Model") and game.Players.LocalPlayer.Character == child then
                shouldKeep = true
            end

            if not shouldKeep then
                pcall(function()
                    child:Destroy()
                    objectsDestroyed = objectsDestroyed + 1
                end)
            end
        end

        print(string.format("[VRAM Optimizer] ✅ Destroyed %d non-essential objects", objectsDestroyed))
    end)
end

-- Function to optimize all materials to Plastic (lightest material)
local function optimizeMaterials()
    print("[VRAM Optimizer] 🎨 Optimizing materials to Plastic...")

    pcall(function()
        local workspace = game:GetService("Workspace")
        local materialsOptimized = 0

        local function optimizePart(part)
            if part:IsA("BasePart") then
                part.Material = Enum.Material.Plastic
                part.Reflectance = 0
                part.Transparency = part.Transparency > 0.5 and 1 or part.Transparency -- Keep transparency logic
                materialsOptimized = materialsOptimized + 1
            end
        end

        -- Optimize all descendants in workspace
        for _, descendant in ipairs(workspace:GetDescendants()) do
            pcall(function()
                optimizePart(descendant)
            end)
        end

        print(string.format("[VRAM Optimizer] ✅ Optimized %d materials", materialsOptimized))
    end)
end

-- Function to remove all textures, decals, and surfaceAppearances
local function removeTextures()
    print("[VRAM Optimizer] 🖼️ Removing textures and decals...")

    pcall(function()
        local workspace = game:GetService("Workspace")
        local texturesRemoved = 0

        for _, descendant in ipairs(workspace:GetDescendants()) do
            pcall(function()
                if descendant:IsA("Decal") or descendant:IsA("Texture") or descendant:IsA("SurfaceAppearance") then
                    descendant:Destroy()
                    texturesRemoved = texturesRemoved + 1
                end
            end)
        end

        print(string.format("[VRAM Optimizer] ✅ Removed %d textures/decals", texturesRemoved))
    end)
end

-- Function to destroy all particle emitters and special effects
local function destroyParticlesAndEffects()
    print("[VRAM Optimizer] ✨ Destroying particles and effects...")

    pcall(function()
        local workspace = game:GetService("Workspace")
        local effectsDestroyed = 0

        for _, descendant in ipairs(workspace:GetDescendants()) do
            pcall(function()
                if descendant:IsA("ParticleEmitter") or
                   descendant:IsA("Fire") or
                   descendant:IsA("Smoke") or
                   descendant:IsA("Sparkles") or
                   descendant:IsA("Trail") or
                   descendant:IsA("Beam") then
                    descendant:Destroy()
                    effectsDestroyed = effectsDestroyed + 1
                end
            end)
        end

        print(string.format("[VRAM Optimizer] ✅ Destroyed %d effects", effectsDestroyed))
    end)
end

-- Function to destroy all meshes (aggressive VRAM saving)
local function optimizeMeshes()
    print("[VRAM Optimizer] 📦 Optimizing meshes...")

    pcall(function()
        local workspace = game:GetService("Workspace")
        local meshesOptimized = 0

        for _, descendant in ipairs(workspace:GetDescendants()) do
            pcall(function()
                if descendant:IsA("SpecialMesh") or descendant:IsA("MeshPart") then
                    -- Don't destroy, just minimize texture/detail
                    if descendant:IsA("SpecialMesh") then
                        descendant.TextureId = ""
                    elseif descendant:IsA("MeshPart") then
                        descendant.TextureID = ""
                    end
                    meshesOptimized = meshesOptimized + 1
                end
            end)
        end

        print(string.format("[VRAM Optimizer] ✅ Optimized %d meshes", meshesOptimized))
    end)
end

-- Function to clean up various game objects for performance
local function cleanupEnvironment()
    print("[VRAM Optimizer] 🧹 Cleaning up environment...")

    -- 1. delete remote ini
    pcall(function()
        local remote = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net:FindFirstChild("RE/ObtainedNewFishNotification")
        if remote then
            remote:Destroy()
        end
    end)

    -- 2. delete path ini
    pcall(function()
        if workspace.CurrentCamera then
             workspace.CurrentCamera:Destroy()
        end
    end)

    -- 4. delete seluruh children nya
    pcall(function()
        local waves = workspace:FindFirstChild("!! WAVES ")
        if waves then
            waves:ClearAllChildren()
        end
    end)

    -- 5. delete player lain (children nya) selain player utama
    pcall(function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                player.Character:Destroy()
            end
        end
    end)

    print("[VRAM Optimizer] ✅ Environment cleanup completed")
end

-- ====== MASTER VRAM OPTIMIZATION FUNCTION ======
local function applyMaximumVRAMOptimization()
    print("[VRAM Optimizer] ================================================")
    print("[VRAM Optimizer] 🚀 V3.3 MAXIMUM VRAM OPTIMIZATION STARTING...")
    print("[VRAM Optimizer] ================================================")

    -- Phase 1: Basic optimizations
    ultimatePerformance()
    cleanupEnvironment()

    -- Phase 2: Material & Texture optimization
    optimizeMaterials()
    removeTextures()
    optimizeMeshes()

    -- Phase 3: Effects cleanup
    destroyParticlesAndEffects()

    -- Phase 4: Workspace cleanup - DISABLED (too extreme, prevents game from loading)
    print("[VRAM Optimizer] ⏭️  Skipping workspace 3D object cleanup (too extreme)")
    -- destroyWorkspace3DObjects() -- COMMENTED OUT

    -- Phase 5: DISABLE 3D RENDERING (Nuclear option - maximum VRAM save)
    task.wait(2) -- Wait for cleanup to complete
    disable3DRendering()

    print("[VRAM Optimizer] ================================================")
    print("[VRAM Optimizer] ✅ MAXIMUM VRAM OPTIMIZATION COMPLETED!")
    print("[VRAM Optimizer] 💾 VRAM usage should be reduced by 30-50%")
    print("[VRAM Optimizer] ⚠️  Workspace 3D cleanup disabled to allow game loading")
    print("[VRAM Optimizer] ================================================")
end


-- ====== V3.3 AUTOMATIC MAXIMUM VRAM OPTIMIZATION (PHASE 1: SCRIPT START) ======
-- Apply maximum VRAM optimization on script start
task.spawn(function()
    task.wait(3) -- Wait for game to fully load
    local vramOptSuccess = pcall(applyMaximumVRAMOptimization)
    if not vramOptSuccess then
        warn("⚠️ [VRAM Optimizer] Maximum VRAM optimization failed, falling back to basic optimization...")
        -- Fallback to basic optimization
        pcall(ultimatePerformance)
        pcall(cleanupEnvironment)
    end
end)

-- ====== ANTI-AFK SYSTEM ======
-- Prevents Roblox from disconnecting due to 20 minute idle timeout
local function setupAntiAFK()
    local VirtualUser = game:GetService("VirtualUser")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    -- Method 1: Hook into Roblox's idle detection
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)

    -- Method 2: Periodic random movements (every 5 minutes as backup)
    task.spawn(function()
        while true do
            task.wait(300) -- Every 5 minutes
            pcall(function()
                local character = LocalPlayer.Character
                if character and character:FindFirstChild("Humanoid") then
                    -- Small jump to show activity
                    character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end)
end

-- Initialize Anti-AFK
local antiAfkSuccess = pcall(setupAntiAFK)
if not antiAfkSuccess then
    warn("⚠️ [Auto Fish] Anti-AFK setup failed, continuing...")
end

-- ====================================================================
--                        WEBHOOK CONFIGURATION
-- ====================================================================
--[[
IMPORTANT: Configure your webhooks before running this script!

Required webhook variables (set these in your main.lua or loadstring):
- webhook2: Main webhook for fish notifications and general alerts
- webhook3: Dedicated webhook for connection status (Connect/Disconnect/Online Status)

Example usage in your main.lua:
webhook2 = "https://discord.com/api/webhooks/YOUR_MAIN_WEBHOOK_URL"
webhook3 = "https://discord.com/api/webhooks/YOUR_CONNECTION_WEBHOOK_URL"

Webhook Usage:
- webhook2: Fish notifications, megalodon alerts
- webhook3: Connection status and online monitoring

🆕 NEW ONLINE STATUS SYSTEM Features:
🟢 SMART MESSAGE EDITING: Each account gets its own message that updates every 8 seconds
📝 PERSISTENT MESSAGE ID: Message IDs are saved and reused across sessions
⏰ REAL-TIME UPDATES: Shows uptime, fish count, coins, level with live timestamps
🔄 AUTO RECOVERY: Creates new message if old one becomes invalid
📊 RICH STATUS INFO: Displays comprehensive player statistics
🔴 OFFLINE DETECTION: Automatically updates message to offline when disconnected

Traditional Connection Features (still active):
✅ Sends "Player Connected" when script starts successfully
❌ Sends "Player Disconnected" with detailed reason when issues occur
📊 Includes session duration and freeze detection
⚠️ Ping monitoring enabled (high ping webhook DISABLED - console log only)

Note: All status notifications are sent to webhook3 only
--]]

-- ====================================================================
--                        MODUL-MODUL UTAMA
-- ====================================================================

--[[------------------------------------------------------------------
    MODULE: Lightweight Background Inventory v2.0
    Tujuan: Menjaga inventory tiles tetap ada dengan overhead minimal.
--------------------------------------------------------------------]]
local LightweightInventory = {}
do
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer

    local inventoryController = nil
    local originalDestroyTiles = nil
    local isInventoryHooked = false
    local isLoading = false

    local function getInventoryController()
        if inventoryController then return inventoryController end
        local success, result = pcall(function()
            local controllers = ReplicatedStorage:WaitForChild("Controllers", 5)
            local invModule = controllers:WaitForChild("InventoryController", 5)
            return require(invModule)
        end)
        if success then
            inventoryController = result
            return inventoryController
        end
        return nil
    end

    local function hookInventoryController()
        if isInventoryHooked then return true end
        local ctrl = getInventoryController()
        if not ctrl then return false end
        originalDestroyTiles = ctrl.DestroyTiles
        ctrl.DestroyTiles = function() return end
        isInventoryHooked = true
        return true
    end

    local function refreshInventoryTiles(onCompleteCallback)
        if isLoading then return end
        isLoading = true
        local ctrl = getInventoryController()
        if ctrl and ctrl.InventoryStateChanged then
            pcall(function() ctrl.InventoryStateChanged:Fire("Fish") end)
        end
        task.wait()
        if onCompleteCallback then pcall(onCompleteCallback) end
        isLoading = false
    end

    local function initialLoadInventoryTiles(onCompleteCallback)
        if isLoading then return end
        isLoading = true
        local ctrl = getInventoryController()
        if not ctrl then isLoading = false; return end

        local playerGui = LocalPlayer:WaitForChild("PlayerGui")
        local inventoryGUI = playerGui:FindFirstChild("Inventory")
        local mainFrame = inventoryGUI and inventoryGUI:FindFirstChild("Main")

        if not mainFrame then isLoading = false; return end

        local previousEnabled = inventoryGUI.Enabled
        local previousVisible = mainFrame.Visible

        inventoryGUI.Enabled = true
        mainFrame.Visible = true
        task.wait(0.2)

        pcall(function()
            if ctrl.SetPage then ctrl.SetPage(ctrl, "Items") end
            if ctrl.SetCategory then ctrl.SetCategory(ctrl, "Fishes") end
            if ctrl.InventoryStateChanged then ctrl.InventoryStateChanged:Fire("Fish") end
        end)

        task.wait(0.5)
        inventoryGUI.Enabled = previousEnabled
        mainFrame.Visible = previousVisible
        if onCompleteCallback then pcall(onCompleteCallback) end
        isLoading = false
    end

    function LightweightInventory.start(onRefreshCallback)
        if isInventoryHooked then return end
        task.spawn(function()
            if hookInventoryController() then
                task.wait(1)
                initialLoadInventoryTiles(onRefreshCallback)

                pcall(function()
                    local GuiControl = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("GuiControl"))
                    local invGUI = LocalPlayer.PlayerGui:FindFirstChild("Inventory")
                    GuiControl.GuiUnfocusedSignal:Connect(function(closedGui)
                        if closedGui == invGUI then task.delay(0.5, function() refreshInventoryTiles(onRefreshCallback) end) end
                    end)
                end)

                pcall(function()
                    local fishCaughtEvent = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net:WaitForChild("RE/FishCaught")
                    fishCaughtEvent.OnClientEvent:Connect(function()
                        task.delay(1, function() refreshInventoryTiles(onRefreshCallback) end)
                    end)
                end)
            end
        end)
    end
end

--[[------------------------------------------------------------------
    MODULE: Discord Notifier
    Tujuan: Mengirim notifikasi ke Discord untuk item whitelist.
--------------------------------------------------------------------]]
local DiscordNotifier = {}
do
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    -- Use webhook2 from main.lua if available, otherwise use fallback
    local WEBHOOK_URL = webhook2

    local CONFIG = {
        WEBHOOK_URL = WEBHOOK_URL,
        WHITELIST = {
            ["Megalodon"] = true,
            ["Blob Shark"] = true,
            ["Plasma Shark"] = true,
            ["Frostborn Shark"] = true,
            ["Giant Squid"] = true,
            ["Ghost Shark"] = true,
            ["Robot Kraken"] = true,
            ["Bone Whale"] = true,
            ["Elshark Gran Maja"] = true,
            ["Worm Fish"] = true,
            ["Mosasaur Shark"] = true,
            ["Thin Armor Shark"] = true,
            ["Arrow Artifact"] = true,
            ["Crescent Artifact"] = true,
            ["Diamond Artifact"] = true,
            ["Hourglass Diamond Artifact"] = true
        },
        COOLDOWN_SECONDS = 1,
        
        -- =======================================================================
        -- PENTING: Ganti URL di bawah ini dengan URL gambar dari GitHub Anda!
        -- =======================================================================
        -- Anda BISA menggunakan link GitHub biasa (contoh: https://github.com/user/repo/blob/main/image.png)
        -- Skrip akan otomatis mengubahnya ke format yang benar.
        FISH_IMAGES = {
            ["Megalodon"] = "https://github.com/DarylLoudi/fish-it/blob/main/Megalodon.png",
            ["Blob Shark"] = "https://github.com/DarylLoudi/fish-it/blob/main/blob.png",
            ["Frostborn Shark"] = "https://github.com/DarylLoudi/fish-it/blob/main/frost.png",
            ["Giant Squid"] = "https://github.com/DarylLoudi/fish-it/blob/main/gsquid.png",
            ["Ghost Shark"] = "https://github.com/DarylLoudi/fish-it/blob/main/ghost.png",
            ["Robot Kraken"] = "https://github.com/DarylLoudi/fish-it/blob/main/kraken.png"
        }
    }

    local trackedItemCounts = {}
    local isInitialScan = true
    local lastWebhookTime = 0
    local favoritedItems = {} -- Track items we've already favorited

    -- Function to get item UUID by name from PlayerData
    local function getItemUUIDByName(itemName)
        local success, result = pcall(function()
            local inventoryItems = PlayerData:GetExpect("Inventory").Items
            for _, item in ipairs(inventoryItems) do
                local itemData = ItemUtility:GetItemData(item.Id)
                if itemData and itemData.Data.Name then
                    local name = itemData.Data.Name
                    if name:lower() == itemName:lower() or name:find(itemName) then
                        return item.UUID, name
                    end
                end
            end
            return nil
        end)

        return success and result or nil
    end

    -- Function to check if item is already favorited
    local function isItemFavorited(itemUUID)
        local success, result = pcall(function()
            local inventoryItems = PlayerData:GetExpect("Inventory").Items
            for _, item in ipairs(inventoryItems) do
                if item.UUID == itemUUID then
                    return item.Favorited == true
                end
            end
            return false
        end)

        return success and result or false
    end

    -- Function to favorite an item (NEW items only)
    local function autoFavoriteNewItem(baseName, fullName)
        -- Skip if we've already tried to favorite this exact item
        if favoritedItems[fullName] then
            return
        end

        task.spawn(function()
            task.wait(1) -- Wait for inventory to update

            local uuid, foundName = getItemUUIDByName(baseName)
            if uuid then
                -- Check if already favorited
                if isItemFavorited(uuid) then
                    print(string.format("[Auto Favorite] ⏭️ '%s' already favorited, skipping", foundName))
                    favoritedItems[fullName] = true -- Mark as handled
                    return
                end

                -- Favorite the NEW item
                print(string.format("[Auto Favorite] 🌟 Favoriting NEW item: %s", foundName))

                local success = pcall(function()
                    local FavoriteItemEvent = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net:WaitForChild("RE/FavoriteItem")
                    FavoriteItemEvent:FireServer(uuid)
                end)

                if success then
                    print(string.format("[Auto Favorite] ✅ Successfully favorited: %s", foundName))
                    favoritedItems[fullName] = true -- Mark as favorited
                else
                    warn(string.format("[Auto Favorite] ❌ Failed to favorite: %s", foundName))
                end
            end
        end)
    end

    -- Fungsi untuk mengubah link GitHub biasa menjadi link raw
    local function convertToRawGitHubUrl(url)
        if url and type(url) == "string" and url:match("github.com") and url:match("/blob/") then
            local rawUrl = url:gsub("github.com", "raw.githubusercontent.com")
            rawUrl = rawUrl:gsub("/blob/", "/")
            return rawUrl
        end
        -- Kembalikan URL asli jika bukan format yang diharapkan
        return url
    end

    local function sendNotification(itemData, amount)
        if not WEBHOOK_URL or WEBHOOK_URL == "PASTE_YOUR_WEBHOOK_URL_HERE" then return end
        if tick() - lastWebhookTime < CONFIG.COOLDOWN_SECONDS then return end

        local embed = {
            title = "🎣 Item Langka Ditemukan!",
            description = string.format("**+%d %s** telah ditambahkan ke inventory.", amount, itemData.fullName),
            color = 3066993,
            fields = {
                { name = "👤 Player", value = LocalPlayer.Name, inline = true },
                { name = "🐠 Fish", value = itemData.fullName, inline = true },
                { name = "⚖️ Weight", value = itemData.weight, inline = true },
                { name = "✨ Mutation", value = itemData.mutation, inline = true },
                { name = "🕒 Waktu", value = os.date("%H:%M:%S"), inline = false }
            },
            footer = { text = "Inventory Notifier" }
        }

        -- Ambil URL gambar dari konfigurasi menggunakan nama dasar
        local imageUrl = CONFIG.FISH_IMAGES[itemData.baseName]
        if imageUrl and imageUrl ~= "" then
            local rawImageUrl = convertToRawGitHubUrl(imageUrl)
            embed.thumbnail = { url = rawImageUrl }
        end

        local payload = { embeds = {embed} }
        pcall(function()
            local req = (syn and syn.request) or http_request
            if req then
                req({ Url=WEBHOOK_URL, Method="POST", Headers={["Content-Type"]="application/json"}, Body=HttpService:JSONEncode(payload) })
                lastWebhookTime = tick()
            end
        end)
    end

    function DiscordNotifier.scanInventory()
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        local invContainer = playerGui and playerGui:FindFirstChild("Inventory")
        invContainer = invContainer and invContainer:FindFirstChild("Main")
        invContainer = invContainer and invContainer:FindFirstChild("Content")
        invContainer = invContainer and invContainer:FindFirstChild("Pages")
        invContainer = invContainer and invContainer:FindFirstChild("Inventory")
        if not invContainer then return end

        local currentItemCounts = {}
        for _, tile in ipairs(invContainer:GetChildren()) do
            if tile.Name == "Tile" and tile:FindFirstChild("ItemName") then
                local fullName = tile.ItemName.Text
                
                -- Lakukan pengecekan parsial terhadap whitelist
                for baseName, _ in pairs(CONFIG.WHITELIST) do
                    if string.find(fullName, baseName) then
                        -- Item ada di whitelist, kumpulkan data lengkap
                        local weight = "N/A"
                        if tile:FindFirstChild("WeightFrame") and tile.WeightFrame:FindFirstChild("Weight") then
                            weight = tile.WeightFrame.Weight.Text
                        end
                        
                        local mutation = "None"
                        if tile:FindFirstChild("Variant") and tile.Variant:FindFirstChild("ItemName") then
                            local mutationText = tile.Variant.ItemName.Text
                            if mutationText ~= "Ghoulish" then
                                mutation = mutationText
                            end
                        end

                        local itemKey = fullName .. "_" .. weight .. "_" .. mutation
                        
                        currentItemCounts[itemKey] = {
                            count = (currentItemCounts[itemKey] and currentItemCounts[itemKey].count or 0) + 1,
                            data = {
                                fullName = fullName,
                                baseName = baseName,
                                weight = weight,
                                mutation = mutation
                            }
                        }
                        break -- Hentikan loop jika sudah ketemu match
                    end
                end
            end
        end

        if isInitialScan then
            trackedItemCounts = currentItemCounts
            isInitialScan = false
            return
        end

        for itemKey, currentItem in pairs(currentItemCounts) do
            local previousCount = (trackedItemCounts[itemKey] and trackedItemCounts[itemKey].count) or 0
            if currentItem.count > previousCount then
                -- Send webhook notification
                sendNotification(currentItem.data, currentItem.count - previousCount)

                -- Auto-favorite NEW item (to prevent auto-sell)
                autoFavoriteNewItem(currentItem.data.baseName, currentItem.data.fullName)
            end
        end

        trackedItemCounts = currentItemCounts
    end
end

-- ====================================================================
--              AUTO ARTIFACT SYSTEM - CONFIGURATION
-- ====================================================================
-- Global variable untuk enable/disable dari GitHub
if not AUTO_ARTIFACT then
    AUTO_ARTIFACT = false
end

-- State variables untuk artifact system (MUST be defined before AutoArtifact module)
local isAutoArtifactOn = AUTO_ARTIFACT
local artifactCurrentTemple = 1
local artifactCollected = {false, false, false, false}

-- Konfigurasi temple dan target artifact (MUST be defined before AutoArtifact module)
local ARTIFACT_CONFIG = {
    -- Temple 1: Hourglass Diamond Artifact
    {
        templeName = "Temple 1",
        targetArtifact = "Hourglass Diamond Artifact",
        cframe = CFrame.new(1490.12305, 6.62499952, -850.539307, -0.982308805, -4.67861128e-09, -0.187268242, -7.57854224e-09, 1, 1.47694985e-08, 0.187268242, 1.59274283e-08, -0.982308805)
    },
    -- Temple 2: Arrow Artifact
    {
        templeName = "Temple 2",
        targetArtifact = "Arrow Artifact",
        cframe = CFrame.new(883.964233, 6.62499952, -360.91275, -0.128746182, 9.21072107e-09, 0.991677582, -4.92979968e-09, 1, -9.92803972e-09, -0.991677582, -6.16696871e-09, -0.128746182)
    },
    -- Temple 3: Diamond Artifact
    {
        templeName = "Temple 3",
        targetArtifact = "Diamond Artifact",
        cframe = CFrame.new(1836.77136, 6.62499952, -288.573303, 0.25269559, 7.76984699e-09, -0.967545807, 3.12285877e-08, 1, 1.61864921e-08, 0.967545807, -3.43053443e-08, 0.25269559)
    },
    -- Temple 4: Crescent Artifact
    {
        templeName = "Temple 4",
        targetArtifact = "Crescent Artifact",
        cframe = CFrame.new(1405.67358, 6.17587185, 119.126236, -0.951030135, -6.02376886e-08, 0.309098154, -8.03642095e-08, 1, -5.23817469e-08, -0.309098154, -7.4657045e-08, -0.951030135)
    }
}

--[[------------------------------------------------------------------
    MODULE: Auto Artifact System
    Tujuan: Farming artifact di 4 temple secara berurutan dengan webhook notification
--------------------------------------------------------------------]]
local AutoArtifact = {}
do
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    -- Use webhook2 from main.lua
    local WEBHOOK_URL = webhook2

    -- Load required modules for artifact favoriting
    local ItemUtility, Replion, PlayerData, FavoriteItemEvent

    -- Initialize modules function
    local function initializeModules()
        if not ItemUtility then
            ItemUtility = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ItemUtility"))
        end
        if not Replion then
            Replion = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Replion"))
        end
        if not PlayerData then
            PlayerData = Replion.Client:WaitReplion("Data")
        end
        if not FavoriteItemEvent then
            FavoriteItemEvent = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net:WaitForChild("RE/FavoriteItem")
        end
    end

    -- Function to get artifact UUID from PlayerData inventory
    function AutoArtifact.getArtifactUUID(artifactName)
        -- Initialize modules if not already done
        if not PlayerData then
            initializeModules()
        end

        if not PlayerData then return nil end

        local success, result = pcall(function()
            local inventoryItems = PlayerData:GetExpect("Inventory").Items
            for _, item in ipairs(inventoryItems) do
                local itemData = ItemUtility:GetItemData(item.Id)
                if itemData and itemData.Data.Name then
                    local itemName = itemData.Data.Name
                    -- Exact match - must match exactly (case-insensitive)
                    if itemName:lower() == artifactName:lower() then
                        print(string.format("[Auto Artifact] Found artifact UUID: %s for %s", item.UUID, itemName))
                        return item.UUID, itemName
                    end
                end
            end
            return nil
        end)

        if success and result then
            return result
        else
            return nil
        end
    end

    -- Function to favorite an artifact using UUID
    function AutoArtifact.favoriteArtifact(artifactUUID, artifactName)
        if not artifactUUID then
            warn("[Auto Artifact] Cannot favorite - UUID is nil")
            return false
        end

        -- Initialize modules if not already done
        if not FavoriteItemEvent then
            initializeModules()
        end

        print(string.format("[Auto Artifact] 🌟 Favoriting artifact: %s (UUID: %s)", artifactName, artifactUUID))

        local success = pcall(function()
            FavoriteItemEvent:FireServer(artifactUUID)
        end)

        if success then
            print(string.format("[Auto Artifact] ✅ Successfully favorited: %s", artifactName))
            return true
        else
            warn(string.format("[Auto Artifact] ❌ Failed to favorite: %s", artifactName))
            return false
        end
    end

    -- Check if an item is already favorited
    function AutoArtifact.isItemFavorited(itemUUID)
        if not PlayerData then return false end

        local success, result = pcall(function()
            local inventoryItems = PlayerData:GetExpect("Inventory").Items
            for _, item in ipairs(inventoryItems) do
                if item.UUID == itemUUID then
                    return item.Favorited == true
                end
            end
            return false
        end)

        return success and result or false
    end

    -- Function to auto-favorite all artifacts in inventory (ONLY if not already favorited)
    function AutoArtifact.autoFavoriteAllArtifacts()
        print("[Auto Artifact] 🔍 Checking inventory for NEW artifacts to favorite...")

        local artifactNames = {
            "Arrow Artifact",
            "Crescent Artifact",
            "Diamond Artifact",
            "Hourglass Diamond Artifact"
        }

        local favorited = 0
        local skipped = 0

        for _, artifactName in ipairs(artifactNames) do
            local uuid, fullName = AutoArtifact.getArtifactUUID(artifactName)
            if uuid then
                -- Check if already favorited
                if AutoArtifact.isItemFavorited(uuid) then
                    print(string.format("[Auto Artifact] ⏭️ Skipped '%s' - already favorited", fullName or artifactName))
                    skipped = skipped + 1
                else
                    task.wait(0.5) -- Small delay between favorites
                    local success = AutoArtifact.favoriteArtifact(uuid, fullName or artifactName)
                    if success then
                        favorited = favorited + 1
                    end
                end
            end
        end

        if favorited > 0 then
            print(string.format("[Auto Artifact] ✅ Favorited %d NEW artifact(s)!", favorited))
        end

        if skipped > 0 then
            print(string.format("[Auto Artifact] ⏭️ Skipped %d already-favorited artifact(s)", skipped))
        end

        if favorited == 0 and skipped == 0 then
            print("[Auto Artifact] ℹ️ No artifacts found in inventory")
        end

        return favorited
    end

    -- Check if artifact exists in inventory (GUI-based check)
    function AutoArtifact.hasArtifactInInventory(artifactName)
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        local invContainer = playerGui and playerGui:FindFirstChild("Inventory")
        invContainer = invContainer and invContainer:FindFirstChild("Main")
        invContainer = invContainer and invContainer:FindFirstChild("Content")
        invContainer = invContainer and invContainer:FindFirstChild("Pages")
        invContainer = invContainer and invContainer:FindFirstChild("Inventory")

        if not invContainer then return false end

        for _, tile in ipairs(invContainer:GetChildren()) do
            if tile.Name == "Tile" and tile:FindFirstChild("ItemName") then
                local itemName = tile.ItemName.Text
                -- Exact match - must match exactly (case-insensitive)
                if itemName:lower() == artifactName:lower() then
                    return true, itemName
                end
            end
        end

        return false
    end

    -- Send webhook notification for artifact found
    function AutoArtifact.sendArtifactFoundWebhook(templeName, artifactName, templeNumber)
        if not WEBHOOK_URL or WEBHOOK_URL == "PASTE_YOUR_WEBHOOK_URL_HERE" then return end

        local embed = {
            title = "🏺 Artifact Found!",
            description = string.format("**%s** collected from **%s**", artifactName, templeName),
            color = 16776960, -- Yellow/Gold color
            fields = {
                { name = "👤 Player", value = LocalPlayer.Name, inline = true },
                { name = "🏛️ Temple", value = templeName, inline = true },
                { name = "🏺 Artifact", value = artifactName, inline = true },
                { name = "📍 Progress", value = string.format("%d/4 Temples Completed", templeNumber), inline = false },
                { name = "🕒 Time", value = os.date("%H:%M:%S"), inline = false }
            },
            footer = { text = "Auto Artifact System" }
        }

        local payload = { embeds = {embed} }

        pcall(function()
            local req = (syn and syn.request) or http_request
            if req then
                req({
                    Url = WEBHOOK_URL,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = HttpService:JSONEncode(payload)
                })
            end
        end)
    end

    -- Send webhook notification when all artifacts collected
    function AutoArtifact.sendAllArtifactsCompleteWebhook()
        if not WEBHOOK_URL or WEBHOOK_URL == "PASTE_YOUR_WEBHOOK_URL_HERE" then return end

        local embed = {
            title = "✅ ALL ARTIFACTS COLLECTED!",
            description = "**All 4 artifacts have been successfully collected!**",
            color = 65280, -- Green color
            fields = {
                { name = "👤 Player", value = LocalPlayer.Name, inline = true },
                { name = "🏆 Status", value = "COMPLETE", inline = true },
                { name = "🏺 Artifacts", value = "4/4 Collected", inline = true },
                { name = "🕒 Completed At", value = os.date("%H:%M:%S"), inline = false }
            },
            footer = { text = "Auto Artifact System - Farm Complete!" }
        }

        local payload = { embeds = {embed} }

        pcall(function()
            local req = (syn and syn.request) or http_request
            if req then
                req({
                    Url = WEBHOOK_URL,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = HttpService:JSONEncode(payload)
                })
            end
        end)
    end

    -- Teleport player to temple location
    function AutoArtifact.teleportToTemple(cframeData)
        local character = LocalPlayer.Character
        if not character then return false end

        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return false end

        pcall(function()
            humanoidRootPart.CFrame = cframeData
        end)

        return true
    end

    -- Main artifact checker loop
    function AutoArtifact.startArtifactChecker()
        task.spawn(function()
            print("[Auto Artifact] ================================================")
            print("[Auto Artifact] 🔍 Artifact Checker Loop Started!")
            print("[Auto Artifact] ================================================")

            local lastCheckLog = 0 -- Throttle check logs to reduce memory usage
            local LOG_INTERVAL = 60 -- Log only every 60 seconds instead of every 5s

            while isAutoArtifactOn and artifactCurrentTemple <= 4 do
                -- Get current temple config
                local currentConfig = ARTIFACT_CONFIG[artifactCurrentTemple]

                -- Only log check status every 60 seconds to prevent log spam
                if tick() - lastCheckLog >= LOG_INTERVAL then
                    print(string.format("[Auto Artifact] 🔍 Checking for %s at %s (Temple %d/4)",
                        currentConfig.targetArtifact,
                        currentConfig.templeName,
                        artifactCurrentTemple))
                    lastCheckLog = tick()
                end

                if not artifactCollected[artifactCurrentTemple] then
                    -- Check if target artifact is in inventory
                    local hasArtifact, fullName = AutoArtifact.hasArtifactInInventory(currentConfig.targetArtifact)

                    if hasArtifact then
                        print("[Auto Artifact] ================================================")
                        print(string.format("[Auto Artifact] ✅ ARTIFACT FOUND: %s", fullName))
                        print(string.format("[Auto Artifact] 🏛️ Location: %s", currentConfig.templeName))
                        print("[Auto Artifact] ================================================")

                        -- Mark as collected
                        artifactCollected[artifactCurrentTemple] = true

                        -- Auto-favorite the artifact to prevent auto-sell (ONLY if not already favorited)
                        print("[Auto Artifact] 🌟 Checking if artifact needs favoriting...")
                        task.wait(1) -- Wait for inventory to update

                        local artifactUUID, artifactFullName = AutoArtifact.getArtifactUUID(currentConfig.targetArtifact)
                        if artifactUUID then
                            -- Check if already favorited first
                            if AutoArtifact.isItemFavorited(artifactUUID) then
                                print(string.format("[Auto Artifact] ⏭️ '%s' is already favorited, skipping", artifactFullName or fullName))
                            else
                                print(string.format("[Auto Artifact] 🌟 Favoriting NEW artifact: %s", artifactFullName or fullName))
                                AutoArtifact.favoriteArtifact(artifactUUID, artifactFullName or fullName)
                            end
                        else
                            warn("[Auto Artifact] ⚠️ Could not find artifact UUID for favoriting")
                        end

                        task.wait(1) -- Wait for favorite to process

                        -- Send webhook notification
                        AutoArtifact.sendArtifactFoundWebhook(
                            currentConfig.templeName,
                            fullName or currentConfig.targetArtifact,
                            artifactCurrentTemple
                        )

                        print("[Auto Artifact] 📤 Webhook notification sent!")

                        -- Wait a bit before moving to next temple
                        task.wait(2)

                        -- Move to next temple
                        artifactCurrentTemple = artifactCurrentTemple + 1

                        if artifactCurrentTemple <= 4 then
                            local nextConfig = ARTIFACT_CONFIG[artifactCurrentTemple]
                            print("[Auto Artifact] ================================================")
                            print(string.format("[Auto Artifact] 📍 NEXT TEMPLE: %s", nextConfig.templeName))
                            print(string.format("[Auto Artifact] 🎯 TARGET: %s", nextConfig.targetArtifact))
                            print("[Auto Artifact] ================================================")

                            -- Teleport to next temple
                            task.wait(1)
                            AutoArtifact.teleportToTemple(nextConfig.cframe)
                            print("[Auto Artifact] ✅ Teleported to next temple!")
                            task.wait(3)
                        else
                            -- All artifacts collected!
                            print("[Auto Artifact] ================================================")
                            print("[Auto Artifact] 🎉🎉🎉 ALL ARTIFACTS COLLECTED! 🎉🎉🎉")
                            print("[Auto Artifact] ================================================")

                            -- Send completion webhook
                            AutoArtifact.sendAllArtifactsCompleteWebhook()
                            print("[Auto Artifact] 📤 Completion webhook sent!")

                            -- Stop the system
                            isAutoArtifactOn = false
                            AUTO_ARTIFACT = false
                            print("[Auto Artifact] ✅ System completed successfully!")
                            break
                        end
                    end
                    -- Removed "waiting for artifact" log to prevent spam
                end

                task.wait(5) -- Check every 5 seconds
            end

            if artifactCurrentTemple > 4 then
                print("[Auto Artifact] ================================================")
                print("[Auto Artifact] System stopped - All artifacts collected")
                print("[Auto Artifact] ================================================")
            end
        end)
    end

    -- Initialize and start system if enabled
    function AutoArtifact.initialize()
        if not isAutoArtifactOn then
            print("[Auto Artifact] System disabled (AUTO_ARTIFACT = false)")
            return
        end

        print("[Auto Artifact] ================================================")
        print("[Auto Artifact] 🏺 Auto Artifact System Initializing...")
        print("[Auto Artifact] ================================================")

        -- Reset state if restarting
        if artifactCurrentTemple > 4 then
            artifactCurrentTemple = 1
            artifactCollected = {false, false, false, false}
            print("[Auto Artifact] State reset - starting fresh")
        end

        -- Auto-favorite any existing artifacts in inventory (on startup)
        print("[Auto Artifact] 🌟 Checking for existing artifacts to favorite...")
        task.wait(2) -- Wait for inventory to load
        AutoArtifact.autoFavoriteAllArtifacts()
        task.wait(1)

        -- Teleport to current temple (or first if just starting)
        local currentConfig = ARTIFACT_CONFIG[artifactCurrentTemple]
        print(string.format("[Auto Artifact] 📍 Teleporting to %s for %s", currentConfig.templeName, currentConfig.targetArtifact))

        task.wait(1)
        AutoArtifact.teleportToTemple(currentConfig.cframe)
        task.wait(2)

        print("[Auto Artifact] ✅ Teleport complete - Starting artifact checker...")

        -- Start the checker loop
        AutoArtifact.startArtifactChecker()
    end
end

-- Function to sync AUTO_ARTIFACT global variable with local state
local function syncAutoArtifactState()
    -- DON'T START if Auto Artifact is disabled
    if not isAutoArtifactOn or not AUTO_ARTIFACT then
        print("[Auto Artifact] Sync disabled - AUTO_ARTIFACT is false")
        return
    end

    if not AutoArtifact then
        warn("[Auto Artifact] AutoArtifact module not found - sync disabled")
        return
    end

    task.spawn(function()
        -- Only loop while system is enabled
        while isAutoArtifactOn and AUTO_ARTIFACT do
            task.wait(5) -- Check every 5 seconds (reduced from 1s)

            if AUTO_ARTIFACT ~= isAutoArtifactOn then
                isAutoArtifactOn = AUTO_ARTIFACT
                if isAutoArtifactOn then
                    print("[Auto Artifact] ✅ System enabled via AUTO_ARTIFACT")
                    -- Restart the system
                    pcall(function()
                        if AutoArtifact and AutoArtifact.initialize then
                            AutoArtifact.initialize()
                        end
                    end)
                else
                    print("[Auto Artifact] ❌ System disabled via AUTO_ARTIFACT")
                    break -- Exit loop when disabled
                end
            end
        end
        print("[Auto Artifact] Sync loop stopped")
    end)
end

-- ====================================================================
--                        INISIALISASI & SISA SCRIPT
-- ====================================================================

-- Initialize inventory and notifier systems after game is ready
task.wait(5)

local invSuccess = pcall(function()
    LightweightInventory.start(DiscordNotifier.scanInventory)
end)

if not invSuccess then
    warn("⚠️ [Auto Fish] Inventory system failed to load")
end

-- Initialize Auto Artifact System (ONLY if enabled)
if AUTO_ARTIFACT then
    task.spawn(function()
        task.wait(3) -- Wait for inventory to fully load

        print("[Auto Artifact] AUTO_ARTIFACT = true, starting initialization...")

        if AutoArtifact and AutoArtifact.initialize then
            local artifactSuccess, errorMsg = pcall(function()
                AutoArtifact.initialize()
            end)

            if not artifactSuccess then
                warn("⚠️ [Auto Artifact] Failed to initialize: " .. tostring(errorMsg))
            end
        else
            warn("⚠️ [Auto Artifact] Module not found or incomplete")
        end

        -- Start the sync function AFTER initialization (only if enabled)
        task.wait(1)
        if syncAutoArtifactState and isAutoArtifactOn then
            pcall(syncAutoArtifactState)
        end
    end)
else
    print("[Auto Artifact] AUTO_ARTIFACT = false, system will NOT initialize")
end

-- Sisa script zfish v6.2.lua...
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Modules for totem functionality
local ItemUtility = require(replicatedStorage.Shared.ItemUtility)
local Replion = require(replicatedStorage.Packages.Replion)
local PlayerData = Replion.Client:WaitReplion("Data")

-- ====================================================================
--     BEST ROD & BAIT AUTO EQUIP SYSTEM (Using UUID Detection)
-- ====================================================================

-- Helper function to trim whitespace
local function trim(s)
    if not s then return nil end
    return s:match("^%s*(.-)%s*$")
end

-- Rod ID to Name mapping (untuk logging)
local rodNames = {
    [79] = "Luck Rod",
    [76] = "Carbon Rod",
    [85] = "Grass Rod",
    [77] = "Demascus Rod",
    [78] = "Ice Rod",
    [4] = "Lucky Rod",
    [80] = "Midnight Rod",
    [6] = "Steampunk Rod",
    [7] = "Chrome Rod",
    [5] = "Astral Rod",
    [126] = "Ares Rod"
}

-- Function to detect all rods from PlayerData and find best owned rod
local function detectAndEquipBestRod()
    print("[Auto Equip Rod] ================================================")
    print("[Auto Equip Rod] Starting best rod detection and equip...")

    if not PlayerData then
        warn("[Auto Equip Rod] PlayerData is not available.")
        return false
    end

    local success, inventory = pcall(function()
        return PlayerData:Get("Inventory")
    end)

    if not success or not inventory then
        warn("[Auto Equip Rod] Failed to get inventory from PlayerData")
        return false
    end

    local fishingRods = inventory["Fishing Rods"]
    if not fishingRods or type(fishingRods) ~= "table" then
        warn("[Auto Equip Rod] 'Fishing Rods' category not found")
        return false
    end

    print(string.format("[Auto Equip Rod] Scanning %d total rods in inventory...", #fishingRods))

    -- Scan ALL owned rods and find the best one
    local ownedRods = {}

    for i, rodItem in ipairs(fishingRods) do
        local rodData = ItemUtility:GetItemData(rodItem.Id)
        if rodData and rodData.Data then
            local rodName = trim(rodData.Data.Name)
            local rodUUID = rodItem.UUID
            local rodID = rodItem.Id

            print(string.format("[Auto Equip Rod] Scanning rod %d/%d: '%s' (ID: %d, UUID: %s)", i, #fishingRods, rodName, rodID, rodUUID))

            -- Check if this rod is in our upgrade list
            for rodIndex, listRodID in ipairs(rodIDs) do
                if listRodID == rodID then
                    table.insert(ownedRods, {
                        id = rodID,
                        uuid = rodUUID,
                        name = rodName,
                        priority = rodIndex
                    })
                    print(string.format("[Auto Equip Rod] ✅ Rod in upgrade list: '%s' (Priority: %d/%d)", rodName, rodIndex, #rodIDs))
                    break
                end
            end
        end
    end

    if #ownedRods == 0 then
        warn("[Auto Equip Rod] No rods found in upgrade list!")
        return false
    end

    print(string.format("[Auto Equip Rod] Total rods in upgrade list: %d", #ownedRods))

    -- Sort by priority (higher = better)
    table.sort(ownedRods, function(a, b)
        return a.priority > b.priority
    end)

    local bestRod = ownedRods[1]
    print(string.format("[Auto Equip Rod] 🏆 Best owned rod: '%s' (ID: %d, Priority: %d/%d, UUID: %s)",
        bestRod.name, bestRod.id, bestRod.priority, #rodIDs, bestRod.uuid))

    -- Check if already equipped
    local equippedItems = PlayerData:GetExpect("EquippedItems")
    for _, equippedUUID in ipairs(equippedItems) do
        if equippedUUID == bestRod.uuid then
            print(string.format("[Auto Equip Rod] ✅ '%s' already equipped!", bestRod.name))
            print("[Auto Equip Rod] ================================================")
            return true
        end
    end

    -- Equip the best rod
    print(string.format("[Auto Equip Rod] 🔧 Equipping best rod: '%s' (UUID: %s)", bestRod.name, bestRod.uuid))

    local equipSuccess = pcall(function()
        local EquipItemEvent = replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net:WaitForChild("RE/EquipItem")
        EquipItemEvent:FireServer(bestRod.uuid, "Fishing Rods")
    end)

    if equipSuccess then
        print(string.format("[Auto Equip Rod] ✅ Successfully equipped '%s'!", bestRod.name))
        print("[Auto Equip Rod] Waiting for equip to register...")
        task.wait(2) -- Wait longer for equip to fully register

        -- Verify equip was successful (check if UUID is now in equipped items)
        local verified = false
        local equippedItems = PlayerData:GetExpect("EquippedItems")
        for _, equippedUUID in ipairs(equippedItems) do
            if equippedUUID == bestRod.uuid then
                verified = true
                break
            end
        end

        if verified then
            print(string.format("[Auto Equip Rod] ✅ Verified: '%s' is equipped!", bestRod.name))

            -- Apply rod-specific delays if auto upgrade is enabled
            if upgradeState.rod then
                applyRodDelays(bestRod.id)
            end
        else
            warn(string.format("[Auto Equip Rod] ⚠️ Equip verification failed for '%s' - retrying...", bestRod.name))

            -- Retry equip once
            task.wait(1)
            local retrySuccess = pcall(function()
                local EquipItemEvent = replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net:WaitForChild("RE/EquipItem")
                EquipItemEvent:FireServer(bestRod.uuid, "Fishing Rods")
            end)

            if retrySuccess then
                task.wait(2)
                print(string.format("[Auto Equip Rod] ✅ Retry successful: '%s' equipped!", bestRod.name))

                -- Apply delays after retry
                if upgradeState.rod then
                    applyRodDelays(bestRod.id)
                end
            else
                warn(string.format("[Auto Equip Rod] ❌ Retry failed for '%s'", bestRod.name))
            end
        end

        print("[Auto Equip Rod] ================================================")
        return true
    else
        warn(string.format("[Auto Equip Rod] ❌ Failed to equip '%s'", bestRod.name))
        print("[Auto Equip Rod] ================================================")
        return false
    end
end

-- Function to detect all baits from PlayerData and find best owned bait
local function detectAndEquipBestBait()
    print("[Auto Equip Bait] ================================================")
    print("[Auto Equip Bait] Starting best bait detection and equip...")

    if not PlayerData then
        warn("[Auto Equip Bait] PlayerData is not available.")
        return false
    end

    local success, inventory = pcall(function()
        return PlayerData:Get("Inventory")
    end)

    if not success or not inventory then
        warn("[Auto Equip Bait] Failed to get inventory from PlayerData")
        return false
    end

    local baits = inventory["Baits"]
    if not baits or type(baits) ~= "table" then
        warn("[Auto Equip Bait] 'Baits' category not found")
        return false
    end

    print(string.format("[Auto Equip Bait] Scanning %d total baits in inventory...", #baits))

    -- Scan ALL owned baits and find the best one
    local ownedBaits = {}

    for i, baitItem in ipairs(baits) do
        local baitData = ItemUtility:GetBaitData(baitItem.Id)
        if baitData and baitData.Data then
            local baitName = trim(baitData.Data.Name)
            local baitID = baitData.Data.Id

            print(string.format("[Auto Equip Bait] Scanning bait %d/%d: '%s' (ID: %d)", i, #baits, baitName, baitID))

            -- Check if this bait is in our upgrade list
            for baitIndex, listBaitID in ipairs(baitIDs) do
                if listBaitID == baitID then
                    table.insert(ownedBaits, {
                        id = baitID,
                        name = baitName,
                        priority = baitIndex
                    })
                    print(string.format("[Auto Equip Bait] ✅ Bait in upgrade list: '%s' (Priority: %d/%d)", baitName, baitIndex, #baitIDs))
                    break
                end
            end
        end
    end

    if #ownedBaits == 0 then
        warn("[Auto Equip Bait] No baits found in upgrade list!")
        return false
    end

    print(string.format("[Auto Equip Bait] Total baits in upgrade list: %d", #ownedBaits))

    -- Sort by priority (higher = better)
    table.sort(ownedBaits, function(a, b)
        return a.priority > b.priority
    end)

    local bestBait = ownedBaits[1]
    print(string.format("[Auto Equip Bait] 🏆 Best owned bait: '%s' (ID: %d, Priority: %d/%d)",
        bestBait.name, bestBait.id, bestBait.priority, #baitIDs))

    -- Check if already equipped
    local equippedBaitId = PlayerData:GetExpect("EquippedBaitId")
    if equippedBaitId == bestBait.id then
        print(string.format("[Auto Equip Bait] ✅ '%s' already equipped!", bestBait.name))
        print("[Auto Equip Bait] ================================================")
        return true
    end

    -- Equip the best bait
    print(string.format("[Auto Equip Bait] 🔧 Equipping best bait: '%s' (ID: %d)", bestBait.name, bestBait.id))

    local equipSuccess = pcall(function()
        local EquipBaitEvent = replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net:WaitForChild("RE/EquipBait")
        EquipBaitEvent:FireServer(bestBait.id)
    end)

    if equipSuccess then
        print(string.format("[Auto Equip Bait] ✅ Successfully equipped '%s'!", bestBait.name))
        print("[Auto Equip Bait] Waiting for equip to register...")
        task.wait(2) -- Wait longer for equip to fully register

        -- Verify equip was successful (check if ID is now equipped)
        local verified = false
        local equippedBaitId = PlayerData:GetExpect("EquippedBaitId")
        if equippedBaitId == bestBait.id then
            verified = true
        end

        if verified then
            print(string.format("[Auto Equip Bait] ✅ Verified: '%s' is equipped!", bestBait.name))
        else
            warn(string.format("[Auto Equip Bait] ⚠️ Equip verification failed for '%s' - retrying...", bestBait.name))

            -- Retry equip once
            task.wait(1)
            local retrySuccess = pcall(function()
                local EquipBaitEvent = replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net:WaitForChild("RE/EquipBait")
                EquipBaitEvent:FireServer(bestBait.id)
            end)

            if retrySuccess then
                task.wait(2)
                print(string.format("[Auto Equip Bait] ✅ Retry successful: '%s' equipped!", bestBait.name))
            else
                warn(string.format("[Auto Equip Bait] ❌ Retry failed for '%s'", bestBait.name))
            end
        end

        print("[Auto Equip Bait] ================================================")
        return true
    else
        warn(string.format("[Auto Equip Bait] ❌ Failed to equip '%s'", bestBait.name))
        print("[Auto Equip Bait] ================================================")
        return false
    end
end

local leaderstats = player:WaitForChild("leaderstats")
local BestCaught = leaderstats:WaitForChild("Rarest Fish")
local AllTimeCaught = leaderstats:WaitForChild("Caught")

-- ====== FISHING STATS TRACKING VARIABLES ======
local startTime = os.time() -- Using os.time() for stable uptime calculation
local sessionStats = {
    totalFish = 0,
    totalValue = 0,
    bestFish = {name = "None", value = 0},
    fishTypes = {}
}

-- ====== STUCK DETECTION DISABLED ======
-- Removed to reduce complexity and register usage

-- ====================================================================
-- FPS TRACKING REMOVED
-- Reason: Reduce CPU usage (was called EVERY FRAME = millions of calls/day)
-- Impact: FPS display on white screen will show 0 (if GPU Saver is used)
-- Benefit: Significant CPU reduction, especially at higher framerates
-- ====================================================================

local RunService = game:GetService("RunService")
-- Removed variables: frameCount, lastFPSUpdate, currentFPS
-- Removed function: updateFPS()
-- Removed: RunService.Heartbeat:Connect(updateFPS)

-- Database ikan lengkap
local fishDatabase = {
    [163] = {name = "Viperfish", sellPrice = 94}
}
-- State variables
local isAutoFarmOn = false
local isAutoSellOn = false
local isAutoCatchOn = false
local isAutoWeatherOn = false
local gpuSaverEnabled = false
local isAutoMegalodonOn = false
local megalodonLockActive = false
local megalodonLockConnection = nil

local isAutoPreset1On = false
local isAutoPreset2On = false
local isAutoPreset3On = false

-- (Auto Artifact configuration moved to top of script - line 442+)

-- Megalodon event variables
local megalodonEventActive = false
local megalodonMissingAlertSent = false
local megalodonEventStartedAt = 0
local megalodonEventEndAlertSent = false
local megalodonPreEventFarmState = nil

local HttpService = game:GetService("HttpService")

-- Config folder constant
local CONFIG_FOLDER = "ConfigFishIt"

-- Function to ensure config folder exists
local function ensureConfigFolder()
    if not isfolder then
        warn("[Config] Folder functions not available")
        return false
    end

    if not isfolder(CONFIG_FOLDER) then
        local success = pcall(function()
            makefolder(CONFIG_FOLDER)
        end)

        if success then
            return true
        else
            warn("[Config] Failed to create config folder")
            return false
        end
    end

    return true
end

-- Dynamic config file based on player username
local function getConfigFileName()
    local playerName = LocalPlayer.Name or "Unknown"
    local userId = LocalPlayer.UserId or 0
    -- Sanitize filename by removing invalid characters
    playerName = playerName:gsub("[<>:\"/\\|?*]", "_")
    -- Use both username and userId for unique identification
    local fileName = "auto_fish_v58_config_" .. playerName .. "_" .. userId .. ".json"
    return CONFIG_FOLDER .. "/" .. fileName
end
local defaultConfig = {
    autoFarm = false,
    autoSell = false,
    autoCatch = false,
    autoWeather = false,
    autoMegalodon = false,
    activePreset = "none",
    gpuSaver = false,
    teleportLocation = "Sisyphus Statue",
    autoUpgradeRod = false,
    autoUpgradeBait = false,
    chargeFishingDelay = 0.01,
    autoFishDelay = 0.9,
    autoSellDelay = 45,
    autoCatchDelay = 0.2,
    weatherIdDelay = 33,
    weatherCycleDelay = 100
}
local config = {}
for key, value in pairs(defaultConfig) do
    config[key] = value
end

local isApplyingConfig = false

local function validateConfigStructure(loadedConfig)
    -- Ensure all required fields exist with proper defaults
    local validatedConfig = {}

    for key, defaultValue in pairs(defaultConfig) do
        if loadedConfig[key] ~= nil then
            -- Validate data type matches default
            if type(loadedConfig[key]) == type(defaultValue) then
                validatedConfig[key] = loadedConfig[key]
            else
                print("Warning: Config field '" .. key .. "' has wrong type, using default")
                validatedConfig[key] = defaultValue
            end
        else
            validatedConfig[key] = defaultValue
        end
    end

    return validatedConfig
end

local function saveConfig()
    if not writefile then
        return
    end

    -- Ensure config folder exists
    if not ensureConfigFolder() then
        warn("[Config] Cannot create config folder, save aborted")
        return
    end

    local success, encoded = pcall(function()
        return HttpService:JSONEncode(config)
    end)

    if success then
        local configFile = getConfigFileName()
        local writeSuccess = pcall(function()
            writefile(configFile, encoded)
        end)

        if writeSuccess then
        else
            warn("[Config] Failed to write config file")
        end
    else
        warn("[Config] Failed to encode config to JSON")
    end
end

local function loadConfig()
    if not readfile or not isfile then
        config = {}
        for key, value in pairs(defaultConfig) do
            config[key] = value
        end
        return
    end

    -- Ensure config folder exists
    ensureConfigFolder()

    local configFile = getConfigFileName()

    local success, content = pcall(function()
        if isfile(configFile) then
            return readfile(configFile)
        end
        return nil
    end)

    if success and content and content ~= "" then
        local ok, decoded = pcall(function()
            return HttpService:JSONDecode(content)
        end)

        if ok and type(decoded) == "table" then
            config = validateConfigStructure(decoded)
        else
            print("[Config] Failed to decode JSON, using defaults")
            config = {}
            for key, value in pairs(defaultConfig) do
                config[key] = value
            end
        end
    else
        config = {}
        for key, value in pairs(defaultConfig) do
            config[key] = value
        end
    end

    -- Don't auto-save here, let the manual config section handle it
end

local function migrateOldConfig()
    -- Check for old config file format and migrate if found
    if not readfile or not isfile then return end

    -- Check for old format files (both with and without UserID)
    local playerName = (LocalPlayer.Name or "Unknown"):gsub("[<>:\"/\\|?*]", "_")
    local userId = LocalPlayer.UserId or 0

    local oldConfigFiles = {
        "auto_fish_v58_config_" .. playerName .. ".json", -- Very old format
        "auto_fish_v58_config_" .. playerName .. "_" .. userId .. ".json" -- Previous format (without folder)
    }

    for _, oldConfigFile in ipairs(oldConfigFiles) do
        if isfile(oldConfigFile) then

            local success, content = pcall(function()
                return readfile(oldConfigFile)
            end)

            if success and content and content ~= "" then
                local ok, decoded = pcall(function()
                    return HttpService:JSONDecode(content)
                end)

                if ok and type(decoded) == "table" then
                    -- Migrate to new format (with folder)
                    config = validateConfigStructure(decoded)
                    saveConfig()

                    -- Optionally delete old file
                    pcall(function()
                        if delfile then
                            delfile(oldConfigFile)
                        end
                    end)

                    return true
                end
            end
        end
    end

    return false
end

local function updateConfigField(key, value)
    if defaultConfig[key] == nil then
        warn("[Config] Attempted to set unknown config field: " .. tostring(key))
        return
    end

    if type(value) ~= type(defaultConfig[key]) then
        warn("[Config] Type mismatch for field '" .. tostring(key) .. "'. Expected " .. type(defaultConfig[key]) .. ", got " .. type(value))
        return
    end

    config[key] = value
    if not isApplyingConfig then
        local success = pcall(saveConfig)
        if not success then
            warn("[Config] Failed to save config after updating field: " .. tostring(key))
        end
    end
end

local function syncConfigFromStates()
    config.autoFarm = isAutoFarmOn
    config.autoSell = isAutoSellOn
    config.autoCatch = isAutoCatchOn
    config.autoWeather = isAutoWeatherOn
    config.autoMegalodon = isAutoMegalodonOn
    config.gpuSaver = gpuSaverEnabled
    config.chargeFishingDelay = chargeFishingDelay
    config.autoFishMainDelay = autoFishMainDelay
    config.autoSellDelay = autoSellDelay
    config.autoCatchDelay = autoCatchDelay
    config.weatherIdDelay = weatherIdDelay
    config.weatherCycleDelay = weatherCycleDelay
end

local function applyDelayConfig()
    if not config then
        return
    end

    local previousState = isApplyingConfig
    local updated = false
    isApplyingConfig = true

    local function applyField(field, minValue, defaultValue)
        local value = tonumber(config[field])
        if value == nil or value == 0 then
            value = defaultValue or 0.1
            updated = true
        end
        -- Ensure we have a valid number before math.max
        value = tonumber(value) or defaultValue or 0.1
        local clamped = math.max(minValue, value)
        if clamped ~= value then
            updated = true
        end
        config[field] = clamped
        return clamped
    end

    chargeFishingDelay = applyField("chargeFishingDelay", 0.01, defaultConfig.chargeFishingDelay)
    autoFishMainDelay = applyField("autoFishDelay", 0.1, defaultConfig.autoFishDelay)
    autoSellDelay = applyField("autoSellDelay", 30, defaultConfig.autoSellDelay)
    autoCatchDelay = applyField("autoCatchDelay", 0.01, defaultConfig.autoCatchDelay)
    weatherIdDelay = applyField("weatherIdDelay", 1, defaultConfig.weatherIdDelay)
    weatherCycleDelay = applyField("weatherCycleDelay", 10, defaultConfig.weatherCycleDelay)

    if updated then
        pcall(saveConfig)
    end

    isApplyingConfig = previousState
end

local function roundDelay(value)
    return math.floor(value * 100 + 0.5) / 100
end

local function setChargeFishingDelay(value)
    local numeric = tonumber(value) or chargeFishingDelay
    local clamped = math.max(0.01, numeric)
    clamped = roundDelay(clamped)
    if math.abs(clamped - chargeFishingDelay) < 0.001 then
        return
    end
    chargeFishingDelay = clamped
    updateConfigField("chargeFishingDelay", clamped)
end

local function setAutoFishMainDelay(value)
    local numeric = tonumber(value) or autoFishMainDelay
    local clamped = math.max(0.1, numeric)
    clamped = roundDelay(clamped)
    if math.abs(clamped - autoFishMainDelay) < 0.001 then
        return
    end
    autoFishMainDelay = clamped
    updateConfigField("autoFishMainDelay", clamped)
end

local function setAutoSellDelay(value)
    local numeric = tonumber(value) or autoSellDelay
    local clamped = math.max(1, numeric)
    clamped = roundDelay(clamped)
    if math.abs(clamped - autoSellDelay) < 0.001 then
        return
    end
    autoSellDelay = clamped
    updateConfigField("autoSellDelay", clamped)
end

local function setAutoCatchDelay(value)
    local numeric = tonumber(value) or autoCatchDelay
    local clamped = math.max(0.1, numeric)
    clamped = roundDelay(clamped)
    if math.abs(clamped - autoCatchDelay) < 0.001 then
        return
    end
    autoCatchDelay = clamped
    updateConfigField("autoCatchDelay", clamped)
end

local function setWeatherIdDelay(value)
    local numeric = tonumber(value) or weatherIdDelay
    local clamped = math.max(1, numeric)
    clamped = roundDelay(clamped)
    if math.abs(clamped - weatherIdDelay) < 0.001 then
        return
    end
    weatherIdDelay = clamped
    updateConfigField("weatherIdDelay", clamped)
end

local function setWeatherCycleDelay(value)
    local numeric = tonumber(value) or weatherCycleDelay
    local clamped = math.max(10, numeric)
    clamped = roundDelay(clamped)
    if math.abs(clamped - weatherCycleDelay) < 0.001 then
        return
    end
    weatherCycleDelay = clamped
    updateConfigField("weatherCycleDelay", clamped)
end

-- Try to migrate old config first, then load current config
if not migrateOldConfig() then
    loadConfig()
end

applyDelayConfig()

-- Player identification info

local autoMegalodonToggle
local autoPreset1Toggle
local autoPreset2Toggle
local autoPreset3Toggle
local gpuSaverToggle
local chargeFishingSlider
local autoFishMainSlider
local autoSellSlider
local autoCatchSlider
local weatherIdSlider
local weatherCycleSlider
local upgradeRodToggle
local upgradeBaitToggle

-- ====== AUTO UPGRADE STATE & DATA (From Fish v3) ======
-- Convert upgrade system to globals to save local register space
-- Urutan rod dan bait dari terburuk ke terbaik (index lebih besar = lebih bagus)
upgradeState = { rod = false, bait = false }
rodIDs = {79, 76, 85, 77, 78, 4, 80, 6, 7, 5, 126} -- Dari Luck Rod ke Ares Rod (best)
baitIDs = {10, 2, 3, 17, 6, 8, 15, 16} -- Dari Topwater ke Aether (best)
rodPrices = {[79]=300,[76]=900,[85]=1500,[77]=3000,[78]=5000,[4]=15000,[80]=50000,[6]=215000,[7]=437000,[5]=1000000,[126]=2500000}
baitPrices = {[10]=100,[2]=1000,[3]=3000,[17]=83500,[6]=290000,[8]=630000,[15]=1150000,[16]=3700000}
failedRodAttempts, failedBaitAttempts, rodFailedCounts, baitFailedCounts = {}, {}, {}, {}
currentRodTarget, currentBaitTarget = nil, nil

function findNextRodTarget()local a=1;if currentRodTarget then for c=1,#rodIDs do if rodIDs[c]==currentRodTarget then a=c+1;break end end end;for c=a,#rodIDs do local b=rodIDs[c];if rodPrices[b]and(not rodFailedCounts[b]or rodFailedCounts[b]<3)then return b end end;return nil end
function findNextBaitTarget()local a=1;if currentBaitTarget then for c=1,#baitIDs do if baitIDs[c]==currentBaitTarget then a=c+1;break end end end;for c=a,#baitIDs do local b=baitIDs[c];if baitPrices[b]and(not baitFailedCounts[b]or baitFailedCounts[b]<3)then return b end end;return nil end
function getAffordableRod(a)if not currentRodTarget then return end;local b=rodPrices[currentRodTarget];if not b then currentRodTarget=findNextRodTarget();return end;if failedRodAttempts[currentRodTarget]and tick()-failedRodAttempts[currentRodTarget]<30 then return end;if a>=b then return currentRodTarget,b end end
function getAffordableBait(a)if not currentBaitTarget then return end;local b=baitPrices[currentBaitTarget];if not b then currentBaitTarget=findNextBaitTarget();return end;if failedBaitAttempts[currentBaitTarget]and tick()-failedBaitAttempts[currentBaitTarget]<30 then return end;if a>=b then return currentBaitTarget,b end end
-- ====== END AUTO UPGRADE ======

-- ====== SHOP PURCHASE FUNCTIONS (GLOBALS TO SAVE LOCAL REGISTERS) ======
rodDatabase = {luck=79,carbon=76,grass=85,demascus=77,ice=78,lucky=4,midnight=80,steampunk=6,chrome=7,astral=5,ares=126}
baitDatabase = {topwaterbait=10,luckbait=2,midnightbait=3,deepbait=17,chromabait=6,darkmatterbait=8,corruptbait=15,aetherbait=16}

-- Manual purchase functions (globals to reduce local register usage)
function buyRod(a)
end
function buyBait(a)
end
function shopAutoPurchaseOnStartup()
    -- buyRod(rodDatabase.ares) -- Ares Rod
end
--- ====== END SHOP FUNCTIONS ======

-- ====== COIN/LEVEL FUNCTIONS (GLOBAL TO SAVE REGISTERS) ======
function getCurrentCoins()local a="0";local b,c=pcall(function()local d=LocalPlayer:FindFirstChild("PlayerGui")local e=d and d:FindFirstChild("Events")local f=e and e:FindFirstChild("Frame")local g=f and f:FindFirstChild("CurrencyCounter")local h=g and g:FindFirstChild("Counter")return h and h.Text end)if b and c then a=c end;local i=a:gsub(",","")local j=0;if i:lower():find("k")then local k=i:lower():gsub("k","")j=(tonumber(k)or 0)*1000 elseif i:lower():find("m")then local k=i:lower():gsub("m","")j=(tonumber(k)or 0)*1000000 else j=tonumber(i)or 0 end;return j end
function getCurrentLevel()local a,b=pcall(function()local c=LocalPlayer:FindFirstChild("PlayerGui")if not c then return"Lvl 0"end;local d=c:FindFirstChild("XP")if not d then return"Lvl 0"end;local e=d:FindFirstChild("Frame")if not e then return"Lvl 0"end;local f=e:FindFirstChild("LevelCount")if not f then return"Lvl 0"end;return f.Text or"Lvl 0"end)return a and b or"Lvl 0"end

-- ====== HELPER FUNCTIONS (GLOBAL TO SAVE REGISTERS) ======
function getFishCaught()local a,b=pcall(function()if LocalPlayer.leaderstats and LocalPlayer.leaderstats.Caught then return LocalPlayer.leaderstats.Caught.Value end;return 0 end)return a and b or 0 end
function getBestFish()local a,b=pcall(function()if LocalPlayer.leaderstats and LocalPlayer.leaderstats["Rarest Fish"]then return LocalPlayer.leaderstats["Rarest Fish"].Value end;return"None"end)return a and b or"None"end
function getQuestText(a)local b,c=pcall(function()local d=workspace:FindFirstChild("!!! MENU RINGS")if not d then return"Quest not found"end;local e=d:FindFirstChild("Deep Sea Tracker")if not e then return"Quest not found"end;local f=e:FindFirstChild("Board")if not f then return"Quest not found"end;local g=f:FindFirstChild("Gui")if not g then return"Quest not found"end;local h=g:FindFirstChild("Content")if not h then return"Quest not found"end;local i=h:FindFirstChild(a)if not i then return"Quest not found"end;return i.Text or"No data"end)return b and c or"Error fetching quest"end

-- ====== STATS/FORMAT FUNCTIONS (GLOBAL TO SAVE REGISTERS) ======
function FormatTime(a)a=tonumber(a)or 0;a=math.max(0,math.floor(a))local b=math.floor(a/3600)local c=math.floor((a%3600)/60)local d=a%60;return string.format("%02d:%02d:%02d",b,c,d)end
function FormatNumber(a)local b=tonumber(a)or 0;local c=tostring(math.floor(b))local d;while true do c,d=string.gsub(c,"^(-?%d+)(%d%d%d)",'%1,%2')if d==0 then break end end;return c end
function FormatCoins(coins)
    local num = tonumber(coins) or 0
    if num >= 1000000 then
        return string.format("%.1fM", num / 1000000)
    elseif num >= 1000 then
        return string.format("%.1fK", num / 1000)
    else
        return tostring(math.floor(num))
    end
end

-- ====== TOTEM DETECTION & EQUIP FUNCTIONS ======

-- Function to detect totem UUID from PlayerData inventory (category "Totems")
local function detectTotemUUID(totemName)
    if not PlayerData then
        warn("[Totem Detect] ❌ PlayerData not available")
        return nil, nil
    end

    local success, uuid, foundName = pcall(function()
        local inventory = PlayerData:Get("Inventory")
        if not inventory then
            warn("[Totem Detect] ❌ Inventory not found")
            return nil, nil
        end

        local totems = inventory["Totems"]
        if not totems or type(totems) ~= "table" then
            warn("[Totem Detect] ❌ Totems category not found in inventory")
            return nil, nil
        end

        print(string.format("[Totem Detect] 🔍 Scanning %d totems in inventory...", #totems))

        for i, totemItem in ipairs(totems) do
            local totemData = ItemUtility.GetItemDataFromItemType("Totems", totemItem.Id)
            if totemData and totemData.Data then
                local itemName = totemData.Data.Name
                print(string.format("[Totem Detect] 📦 Found totem %d/%d: '%s' (UUID: %s)", i, #totems, itemName, totemItem.UUID))

                -- Match totem by name (exact or partial)
                if totemName and string.find(itemName:lower(), totemName:lower()) then
                    print(string.format("[Totem Detect] ✅ MATCH! Selected totem: '%s' (UUID: %s)", itemName, totemItem.UUID))
                    return totemItem.UUID, itemName
                elseif not totemName then
                    -- Return first totem if no specific name requested
                    print(string.format("[Totem Detect] ✅ No filter specified, using first totem: '%s' (UUID: %s)", itemName, totemItem.UUID))
                    return totemItem.UUID, itemName
                end
            else
                warn(string.format("[Totem Detect] ⚠️ Could not get data for totem ID: %s", tostring(totemItem.Id)))
            end
        end

        warn("[Totem Detect] ❌ No matching totem found")
        return nil, nil
    end)

    if success then
        return uuid, foundName
    else
        warn("[Totem Detect] ❌ Error during detection: " .. tostring(uuid))
        return nil, nil
    end
end

-- Function to find totem's hotbar slot by UUID
local function findTotemHotbarSlot(targetUUID)
    if not targetUUID or not PlayerData then return nil end

    local success, result = pcall(function()
        local equippedItems = PlayerData:GetExpect("EquippedItems")
        if not equippedItems or type(equippedItems) ~= "table" then return nil end

        -- Search through hotbar slots (1-based index)
        for slotIndex, equippedUUID in ipairs(equippedItems) do
            if equippedUUID == targetUUID then
                print(string.format("[Totem Detect] ✅ Totem found in hotbar slot %d", slotIndex))
                return slotIndex
            end
        end

        return nil
    end)

    return success and result or nil
end

-- Function to equip totem to hotbar (if not already equipped)
local function equipTotemToHotbar(totemUUID, totemName)
    if not totemUUID or not PlayerData then
        warn("[Totem Equip] ❌ Invalid totem UUID or PlayerData missing")
        return false
    end

    -- Check if already in hotbar
    local currentSlot = findTotemHotbarSlot(totemUUID)
    if currentSlot then
        print(string.format("[Totem Equip] ⏭️ Totem '%s' already in hotbar slot %d", totemName or "Unknown", currentSlot))
        return true, currentSlot
    end

    -- Equip to hotbar
    print(string.format("[Totem Equip] 🔧 Equipping totem '%s' to hotbar...", totemName or "Unknown"))

    local equipSuccess = pcall(function()
        local EquipItemEvent = replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net:WaitForChild("RE/EquipItem")
        EquipItemEvent:FireServer(totemUUID, "Totems")
    end)

    if not equipSuccess then
        warn("[Totem Equip] ❌ Failed to equip totem to hotbar")
        return false
    end

    task.wait(2) -- Wait for equip to register

    -- Verify equip and get slot
    local verifiedSlot = findTotemHotbarSlot(totemUUID)
    if verifiedSlot then
        print(string.format("[Totem Equip] ✅ Totem equipped to hotbar slot %d", verifiedSlot))
        return true, verifiedSlot
    else
        warn("[Totem Equip] ⚠️ Equip verification failed")
        return false
    end
end

-- Function to spawn totem at player's location
local function spawnTotem(totemUUID, totemName)
    if not totemUUID then
        warn("[Totem Spawn] ❌ Invalid totem UUID")
        return false
    end

    print(string.format("[Totem Spawn] 🗿 Spawning totem '%s' (UUID: %s)...", totemName or "Unknown", totemUUID))

    local spawnSuccess = pcall(function()
        local net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
        local spawnTotemEvent = net:FindFirstChild("RE/SpawnTotem")

        if spawnTotemEvent then
            spawnTotemEvent:FireServer(totemUUID)
            print("[Totem Spawn] ✅ Spawn request sent!")
        else
            warn("[Totem Spawn] ⚠️ SpawnTotem event not found")
            return false
        end
    end)

    if spawnSuccess then
        task.wait(1.5) -- Wait for spawn animation
        print("[Totem Spawn] ✅ Totem spawned successfully!")
        return true
    else
        warn("[Totem Spawn] ❌ Failed to spawn totem")
        return false
    end
end

-- ====== TOTEM PURCHASE FUNCTIONS ======

local function buyTotem()
    task.spawn(function()
        print("[Buy Totem] ================================================")
        print("[Buy Totem] Starting totem purchase sequence...")
        print("[Buy Totem] ================================================")

        -- Step 1: Force stop auto farm and ensure it stays off
        print("[Buy Totem] [1/7] Stopping auto farm...")
        local wasAutoFarmOn = isAutoFarmOn
        isAutoFarmOn = false -- Force disable immediately

        -- Double check to ensure auto farm is really off
        task.wait(0.5)
        isAutoFarmOn = false -- Force again

        -- Wait 3 seconds for fishing to complete if player is waiting for fish
        print("[Buy Totem] Waiting 3 seconds for any pending fishing to complete...")
        task.wait(3)

        print("[Buy Totem] ✅ Auto farm stopped (was " .. (wasAutoFarmOn and "ON" or "OFF") .. ")")

        -- Step 2: Spam sell all 3x to ensure everything is sold
        print("[Buy Totem] [2/7] Selling all items (3x spam)...")

        -- Sell attempt 1
        pcall(function()
            local net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
            local sellEventDirect = net["RF/SellAllItems"]
            if sellEventDirect then
                sellEventDirect:InvokeServer()
                print("[Buy Totem] ✅ Sell attempt 1/3")
            end
        end)
        task.wait(1)

        -- Sell attempt 2
        pcall(function()
            local net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
            local sellEventDirect = net["RF/SellAllItems"]
            if sellEventDirect then
                sellEventDirect:InvokeServer()
                print("[Buy Totem] ✅ Sell attempt 2/3")
            end
        end)
        task.wait(1)

        -- Sell attempt 3
        pcall(function()
            local net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
            local sellEventDirect = net["RF/SellAllItems"]
            if sellEventDirect then
                sellEventDirect:InvokeServer()
                print("[Buy Totem] ✅ Sell attempt 3/3")
            end
        end)
        task.wait(2) -- Final wait for all sells to complete

        -- Step 3: Check current coins
        print("[Buy Totem] [3/7] Checking coins...")
        local currentCoins = getCurrentCoins()
        print("[Buy Totem] Current coins: " .. FormatCoins(currentCoins))

        if currentCoins < 2000000 then
            warn("[Buy Totem] ❌ Not enough coins! Need 2M, you have: " .. FormatCoins(currentCoins))
            -- Wait 3 seconds cooldown before restoring
            task.wait(3)
            if wasAutoFarmOn then
                isAutoFarmOn = true
                print("[Buy Totem] Auto farm restored after failure")
            end
            return
        end

        -- Step 4: Purchase totem
        print("[Buy Totem] [4/7] Purchasing Luck Totem...")
        local purchaseSuccess = false

        if networkEvents and networkEvents.purchaseMarketItemEvent then
            purchaseSuccess = pcall(function()
                local result = networkEvents.purchaseMarketItemEvent:InvokeServer(5)
                print("[Buy Totem] Purchase response: " .. tostring(result))
            end)
        else
            -- Alternative method: Direct access
            purchaseSuccess = pcall(function()
                local net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
                local purchaseEvent = net:FindFirstChild("RF/PurchaseMarketItem")
                if purchaseEvent then
                    local result = purchaseEvent:InvokeServer(5)
                    print("[Buy Totem] Purchase response: " .. tostring(result))
                end
            end)
        end

        if not purchaseSuccess then
            warn("[Buy Totem] ❌ Failed to purchase totem")
            -- Wait 3 seconds cooldown before restoring
            task.wait(3)
            if wasAutoFarmOn then
                isAutoFarmOn = true
                print("[Buy Totem] Auto farm restored after failure")
            end
            return
        end

        print("[Buy Totem] ✅ Totem purchased successfully!")
        task.wait(2) -- Wait for inventory to update

        -- Step 5: Detect totem UUID from inventory (category "Totems")
        print("[Buy Totem] [5/7] Detecting totem from inventory...")
        local totemUUID, totemName = detectTotemUUID("Luck Totem") -- Try to find Luck Totem specifically

        if not totemUUID then
            -- If Luck Totem not found, try to find any totem
            print("[Buy Totem] Luck Totem not found, trying to detect any totem...")
            totemUUID, totemName = detectTotemUUID(nil)
        end

        if not totemUUID then
            warn("[Buy Totem] ❌ Failed to detect totem in inventory!")
            -- Wait 3 seconds cooldown before restoring
            task.wait(3)
            if wasAutoFarmOn then
                isAutoFarmOn = true
                print("[Buy Totem] Auto farm restored after failure")
            end
            return
        end

        print(string.format("[Buy Totem] ✅ Detected totem: '%s' (UUID: %s)", totemName or "Unknown", totemUUID or "nil"))

        -- Step 6: Equip totem to hotbar and get slot number
        print("[Buy Totem] [6/7] Equipping totem to hotbar...")
        local equipSuccess, hotbarSlot = equipTotemToHotbar(totemUUID, totemName)

        if not equipSuccess or not hotbarSlot then
            warn("[Buy Totem] ❌ Failed to equip totem to hotbar!")
            -- Wait 3 seconds cooldown before restoring
            task.wait(3)
            if wasAutoFarmOn then
                isAutoFarmOn = true
                print("[Buy Totem] Auto farm restored after failure")
            end
            return
        end

        print(string.format("[Buy Totem] ✅ Totem equipped to hotbar slot %d", hotbarSlot))

        -- Step 7: Spawn the totem
        print("[Buy Totem] [7/7] Spawning totem...")
        local spawnSuccess = spawnTotem(totemUUID, totemName)

        if spawnSuccess then
            print("[Buy Totem] ✅ Totem spawned successfully!")
        else
            warn("[Buy Totem] ⚠️ Totem spawn failed (but purchase and equip succeeded)")
        end

        -- Step 8: Re-equip fishing rod (hotbar slot 2)
        print("[Buy Totem] [8/8] Re-equipping fishing rod...")
        pcall(function()
            local net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
            local equipHotbarEvent = net["RE/EquipToolFromHotbar"]

            if equipHotbarEvent then
                equipHotbarEvent:FireServer(2) -- Assume rod is in slot 2
                print("[Buy Totem] ✅ Fishing rod re-equipped")
            else
                warn("[Buy Totem] ⚠️ EquipToolFromHotbar event not found")
            end
        end)

        task.wait(1)

        -- Step 9: Wait cooldown then restore auto farm
        print("[Buy Totem] Waiting 3 second cooldown before resuming...")
        task.wait(3) -- 3 second cooldown

        if wasAutoFarmOn then
            isAutoFarmOn = true
            print("[Buy Totem] ✅ Auto farm resumed after cooldown")
        else
            print("[Buy Totem] Auto farm was off, keeping it off")
        end

        print("[Buy Totem] ================================================")
        print("[Buy Totem] 🎉 Totem purchase sequence completed!")
        print("[Buy Totem] ================================================")
    end)
end

-- ====== GPU SAVER VARIABLES ======
-- Read GPU_FPS_LIMIT from main_noui.lua if available, otherwise default to 8
if not GPU_FPS_LIMIT then
    GPU_FPS_LIMIT = 8
end
GPU_FPS_LIMIT = tonumber(GPU_FPS_LIMIT) or 8 -- Ensure it's a number

local originalSettings = {}
local whiteScreenGui = nil
local connections = {}
local fpsCapConnection = nil

-- ====== DELAY VARIABLES ======
local chargeFishingDelay = 0.01
local autoFishMainDelay = 0.9
local autoSellDelay = 45
local autoCatchDelay = 0.2
local weatherIdDelay = 33
local weatherCycleDelay = 100

-- ====== ROD-SPECIFIC DELAY MAPPING (from List Best.lua) ======
local rodDelaySettings = {
    [79] = {fish = 7, catch = 1},      -- Luck Rod
    [76] = {fish = 5, catch = 1},      -- Carbon Rod
    [85] = {fish = 5, catch = 1},      -- Grass Rod
    [77] = {fish = 5, catch = 1},      -- Demascus Rod
    [78] = {fish = 5, catch = 1},      -- Ice Rod
    [4] = {fish = 4, catch = 1},       -- Lucky Rod
    [80] = {fish = 4, catch = 1},      -- Midnight Rod
    [6] = {fish = 1, catch = 0.4},     -- Steampunk Rod
    [7] = {fish = 0.3, catch = 0.3},   -- Chrome Rod
    [5] = {fish = 0.1, catch = 0.1},   -- Astral Rod
    [126] = {fish = 0.1, catch = 0.1}  -- Ares Rod
}

-- Function to get currently equipped rod ID
local function getEquippedRodID()
    if not PlayerData then return nil end

    local success, inventory = pcall(function()
        return PlayerData:Get("Inventory")
    end)

    if not success or not inventory then return nil end

    local fishingRods = inventory["Fishing Rods"]
    if not fishingRods or type(fishingRods) ~= "table" then return nil end

    -- Get equipped items
    local equippedItems = PlayerData:GetExpect("EquippedItems")

    -- Find which rod is equipped
    for i, rodItem in ipairs(fishingRods) do
        for _, equippedUUID in ipairs(equippedItems) do
            if equippedUUID == rodItem.UUID then
                return rodItem.Id -- Return equipped rod ID
            end
        end
    end

    return nil
end

-- Function to apply rod-specific delays
local function applyRodDelays(rodID)
    if not rodID then return false end

    local delaySetting = rodDelaySettings[rodID]
    if not delaySetting then
        warn("[Rod Delay] No delay setting found for rod ID: " .. tostring(rodID))
        return false
    end

    -- Update delays
    autoFishMainDelay = delaySetting.fish
    autoCatchDelay = delaySetting.catch

    -- Save to config
    if config then
        config.autoFishDelay = autoFishMainDelay
        config.autoCatchDelay = autoCatchDelay
        saveConfig()
    end

    print(string.format("[Rod Delay] ✅ Delays updated for rod ID %d: Fish=%.1fs, Catch=%.1fs",
        rodID, autoFishMainDelay, autoCatchDelay))

    return true
end

-- Function to detect equipped rod and apply delays
local function detectAndApplyRodDelays()
    local equippedRodID = getEquippedRodID()

    if equippedRodID then
        local rodName = rodNames[equippedRodID] or "Unknown"
        print(string.format("[Rod Delay] Detected equipped rod: %s (ID: %d)", rodName, equippedRodID))
        applyRodDelays(equippedRodID)
        return true
    else
        warn("[Rod Delay] No rod equipped - using default delays")
        return false
    end
end

HOTBAR_SLOT = 2 -- Slot hotbar untuk equip tool (global)


local function getNetworkEvents()
    local success, result = pcall(function()
        local packages = replicatedStorage:WaitForChild("Packages", 10)
        local net = packages:WaitForChild("_Index", 10):WaitForChild("sleitnick_net@0.2.0", 10):WaitForChild("net", 10)
        
        return {
            fishingEvent = net:WaitForChild("RE/FishingCompleted", 10),
            sellEvent = net:WaitForChild("RF/SellAllItems", 10),
            chargeEvent = net:WaitForChild("RF/ChargeFishingRod", 10),
            requestMinigameEvent = net:WaitForChild("RF/RequestFishingMinigameStarted", 10),
            cancelFishingEvent = net:WaitForChild("RF/CancelFishingInputs", 10),
            equipEvent = net:WaitForChild("RE/EquipToolFromHotbar", 10),
            unequipEvent = net:WaitForChild("RE/UnequipToolFromHotbar", 10),
            WeatherEvent = net:WaitForChild("RF/PurchaseWeatherEvent", 10),
            fishCaughtEvent = replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net:WaitForChild("RE/FishCaught", 10),
            -- For Auto Upgrade
            purchaseRodEvent = net:WaitForChild("RF/PurchaseFishingRod", 10),
            purchaseBaitEvent = net:WaitForChild("RF/PurchaseBait", 10),
            equipItemEvent = net:WaitForChild("RE/EquipItem", 10),
            equipBaitEvent = net:WaitForChild("RE/EquipBait", 10),
            -- For Totem Purchase Only (placement is manual)
            purchaseMarketItemEvent = net:WaitForChild("RF/PurchaseMarketItem", 10)
        }
    end)
    
    if success then
        return result
    else
        warn("Failed to get network events: " .. tostring(result))
        return nil
    end
end

-- Get all network events with proper error handling
local networkEvents = getNetworkEvents()
if not networkEvents then
    error("❌ [Auto Fish] Failed to initialize network events. Script cannot continue.")
    return
else
end

-- Extract events for easier access
local fishingEvent = networkEvents.fishingEvent
local sellEvent = networkEvents.sellEvent
local chargeEvent = networkEvents.chargeEvent
local requestMinigameEvent = networkEvents.requestMinigameEvent
local cancelFishingEvent = networkEvents.cancelFishingEvent
local equipEvent = networkEvents.equipEvent
local unequipEvent = networkEvents.unequipEvent
local WeatherEvent = networkEvents.WeatherEvent
local fishCaughtEvent = networkEvents.fishCaughtEvent

-- ====== SIMPLIFIED GPU SAVER WITH CENTER LAYOUT ====== 
local function createWhiteScreen()
    if whiteScreenGui then return end
    
    whiteScreenGui = Instance.new("ScreenGui")
    whiteScreenGui.Name = "GPUSaverScreen"
    whiteScreenGui.ResetOnSpawn = false
    whiteScreenGui.IgnoreGuiInset = true
    whiteScreenGui.DisplayOrder = 999999
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    frame.BorderSizePixel = 0
    frame.Parent = whiteScreenGui
    
    -- Main title with Total Caught and Best Caught
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(0, 600, 0, 100)
    titleLabel.Position = UDim2.new(0.5, -300, 0, 50)
    titleLabel.BackgroundTransparency = 1
    local totalCaught = (LocalPlayer.leaderstats and LocalPlayer.leaderstats.Caught and LocalPlayer.leaderstats.Caught.Value) or 0
    local bestCaught = (LocalPlayer.leaderstats and LocalPlayer.leaderstats["Rarest Fish"] and LocalPlayer.leaderstats["Rarest Fish"].Value) or "None"
    titleLabel.Text = "🟢 " .. LocalPlayer.Name .. "\nTotal Caught: " .. totalCaught .. "\nBest Caught: " .. bestCaught
    titleLabel.TextColor3 = Color3.new(0, 1, 0)
    titleLabel.TextScaled = false
    titleLabel.TextSize = 32
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.Parent = frame
    
    -- Session time (centered)
    local sessionLabel = Instance.new("TextLabel")
    sessionLabel.Name = "SessionLabel"
    sessionLabel.Size = UDim2.new(0, 400, 0, 40)
    sessionLabel.Position = UDim2.new(0.5, -200, 0, 180)
    sessionLabel.BackgroundTransparency = 1
    sessionLabel.Text = "⏱️ Uptime: 00:00:00"
    sessionLabel.TextColor3 = Color3.new(1, 1, 1)
    sessionLabel.TextSize = 22
    sessionLabel.Font = Enum.Font.SourceSansBold
    sessionLabel.TextXAlignment = Enum.TextXAlignment.Center
    sessionLabel.Parent = frame

    -- FPS Counter (centered) - DISABLED to save CPU
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Name = "FPSLabel"
    fpsLabel.Size = UDim2.new(0, 400, 0, 40)
    fpsLabel.Position = UDim2.new(0.5, -200, 0, 200)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "📊 FPS Tracking: Disabled"  -- Changed from currentFPS
    fpsLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7)  -- Gray color to indicate disabled
    fpsLabel.TextSize = 22
    fpsLabel.Font = Enum.Font.SourceSansBold
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Center
    fpsLabel.Parent = frame
    
    -- Fishing stats (centered)
    local fishStatsLabel = Instance.new("TextLabel")
    fishStatsLabel.Name = "FishStatsLabel"
    fishStatsLabel.Size = UDim2.new(0, 400, 0, 40)
    fishStatsLabel.Position = UDim2.new(0.5, -200, 0, 220)
    fishStatsLabel.BackgroundTransparency = 1
    fishStatsLabel.Text = "🎣 Fish Caught: " .. FormatNumber(sessionStats.totalFish)
    fishStatsLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    fishStatsLabel.TextSize = 22
    fishStatsLabel.Font = Enum.Font.SourceSans
    fishStatsLabel.TextXAlignment = Enum.TextXAlignment.Center
    fishStatsLabel.Parent = frame

-- Coin display (mengganti earnings)
    local coinLabel = Instance.new("TextLabel")
    coinLabel.Name = "CoinLabel"
    coinLabel.Size = UDim2.new(0, 400, 0, 40)
    coinLabel.Position = UDim2.new(0.5, -200, 0, 240)
    coinLabel.BackgroundTransparency = 1
    coinLabel.Text = "💰 Coins: " .. FormatCoins(getCurrentCoins())
    coinLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    coinLabel.TextSize = 22
    coinLabel.Font = Enum.Font.SourceSans
    coinLabel.TextXAlignment = Enum.TextXAlignment.Center
    coinLabel.Parent = frame

    -- Level display (tambahan baru)
    local levelLabel = Instance.new("TextLabel")
    levelLabel.Name = "LevelLabel"
    levelLabel.Size = UDim2.new(0, 400, 0, 40)
    levelLabel.Position = UDim2.new(0.5, -200, 0, 260)
    levelLabel.BackgroundTransparency = 1
    levelLabel.Text = "⭐ " .. getCurrentLevel()
    levelLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    levelLabel.TextSize = 22
    levelLabel.Font = Enum.Font.SourceSans
    levelLabel.TextXAlignment = Enum.TextXAlignment.Center
    levelLabel.Parent = frame

        local quest1Label = Instance.new("TextLabel")
    quest1Label.Name = "Quest1Label"
    quest1Label.Size = UDim2.new(0, 600, 0, 30)  -- Lebar lebih untuk 2 quests, height compact
    quest1Label.Position = UDim2.new(0.5, -300, 0, 330)  -- Di bawah level
    quest1Label.BackgroundTransparency = 1
    quest1Label.Text = "🏆 Quest 1: " .. getQuestText("Label1")
    quest1Label.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    quest1Label.TextSize = 20  -- Tetap pas seperti sekarang
    quest1Label.Font = Enum.Font.SourceSans
    quest1Label.TextXAlignment = Enum.TextXAlignment.Center
    quest1Label.TextWrapped = true  -- Wrap jika panjang
    quest1Label.Parent = frame

    local quest2Label = Instance.new("TextLabel")
    quest2Label.Name = "Quest2Label"
    quest2Label.Size = UDim2.new(0, 600, 0, 30)  -- Lebar lebih untuk 2 quests, height compact
    quest2Label.Position = UDim2.new(0.5, -300, 0, 350)  -- Di bawah level
    quest2Label.BackgroundTransparency = 1
    quest2Label.Text = "🏆 Quest 2: " .. getQuestText("Label2")
    quest2Label.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    quest2Label.TextSize = 20  -- Tetap pas seperti sekarang
    quest2Label.Font = Enum.Font.SourceSans
    quest2Label.TextXAlignment = Enum.TextXAlignment.Center
    quest2Label.TextWrapped = true  -- Wrap jika panjang
    quest2Label.Parent = frame

    local quest3Label = Instance.new("TextLabel")
    quest3Label.Name = "Quest3Label"
    quest3Label.Size = UDim2.new(0, 600, 0, 30)  -- Lebar lebih untuk 2 quests, height compact
    quest3Label.Position = UDim2.new(0.5, -300, 0, 370)  -- Di bawah level
    quest3Label.BackgroundTransparency = 1
    quest3Label.Text = "🏆 Quest 3: " .. getQuestText("Label3")
    quest3Label.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    quest3Label.TextSize = 20  -- Tetap pas seperti sekarang
    quest3Label.Font = Enum.Font.SourceSans
    quest3Label.TextXAlignment = Enum.TextXAlignment.Center
    quest3Label.TextWrapped = true  -- Wrap jika panjang
    quest3Label.Parent = frame

    local quest4Label = Instance.new("TextLabel")
    quest4Label.Name = "Quest4Label"
    quest4Label.Size = UDim2.new(0, 600, 0, 30)  -- Lebar lebih untuk 2 quests, height compact
    quest4Label.Position = UDim2.new(0.5, -300, 0, 390)  -- Di bawah level
    quest4Label.BackgroundTransparency = 1
    quest4Label.Text = "🏆 Quest 4: " .. getQuestText("Label4")
    quest4Label.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    quest4Label.TextSize = 20  -- Tetap pas seperti sekarang
    quest4Label.Font = Enum.Font.SourceSans
    quest4Label.TextXAlignment = Enum.TextXAlignment.Center
    quest4Label.TextWrapped = true  -- Wrap jika panjang
    quest4Label.Parent = frame
    
    -- Auto features status (centered)
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(0, 600, 0, 40)
    statusLabel.Position = UDim2.new(0.5, -300, 0, 450)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "🤖 Auto Farm: " .. (isAutoFarmOn and "🟢 ON" or "🔴 OFF") .. 
                      " | Auto Sell: " .. (isAutoSellOn and "🟢 ON" or "🔴 OFF") ..
                      " | Auto Catch: " .. (isAutoCatchOn and "🟢 ON" or "🔴 OFF")
    statusLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    statusLabel.TextSize = 16
    statusLabel.Font = Enum.Font.SourceSans
    statusLabel.TextXAlignment = Enum.TextXAlignment.Center
    statusLabel.TextYAlignment = Enum.TextYAlignment.Center
    statusLabel.Parent = frame

    local extraStatusLabel = Instance.new("TextLabel")
    extraStatusLabel.Name = "ExtraStatusLabel"
    extraStatusLabel.Size = UDim2.new(0, 600, 0, 40)
    extraStatusLabel.Position = UDim2.new(0.5, -300, 0, 470)
    extraStatusLabel.BackgroundTransparency = 1
    extraStatusLabel.Text = "🦈 Auto Megalodon: " .. (isAutoMegalodonOn and "🟢 ON" or "🔴 OFF") ..
                          " | 🌤️ Auto Weather: " .. (isAutoWeatherOn and "🟢 ON" or "🔴 OFF")
    extraStatusLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    extraStatusLabel.TextSize = 16
    extraStatusLabel.Font = Enum.Font.SourceSans
    extraStatusLabel.TextXAlignment = Enum.TextXAlignment.Center
    extraStatusLabel.TextYAlignment = Enum.TextYAlignment.Center
    extraStatusLabel.Parent = frame

    -- Buttons container di bawah (2 buttons horizontal)
    -- Close button (kiri)
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 150, 0, 40)
    closeButton.Position = UDim2.new(0.5, -160, 1, -60)
    closeButton.AnchorPoint = Vector2.new(0, 1)
    closeButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "⚠️ Restore 3D"
    closeButton.TextColor3 = Color3.new(1, 0.8, 0)
    closeButton.TextSize = 14
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.Parent = frame

    -- V3.3: Add tooltip warning
    local tooltip = Instance.new("TextLabel")
    tooltip.Name = "Tooltip"
    tooltip.Size = UDim2.new(0, 300, 0, 50)
    tooltip.Position = UDim2.new(0.5, -150, 1, -120)
    tooltip.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    tooltip.BackgroundTransparency = 0.2
    tooltip.BorderSizePixel = 1
    tooltip.BorderColor3 = Color3.new(1, 0.8, 0)
    tooltip.Text = "⚠️ WARNING: Disabling GPU Saver\nwill INCREASE VRAM usage!"
    tooltip.TextColor3 = Color3.new(1, 1, 0)
    tooltip.TextSize = 12
    tooltip.Font = Enum.Font.SourceSansBold
    tooltip.TextWrapped = true
    tooltip.Visible = false
    tooltip.Parent = frame

    closeButton.MouseEnter:Connect(function()
        tooltip.Visible = true
    end)

    closeButton.MouseLeave:Connect(function()
        tooltip.Visible = false
    end)

    closeButton.MouseButton1Click:Connect(function()
        tooltip.Visible = false
        disableGPUSaver()
    end)

    -- Buy Totem button (kanan)
    local buyTotemButton = Instance.new("TextButton")
    buyTotemButton.Size = UDim2.new(0, 150, 0, 40)
    buyTotemButton.Position = UDim2.new(0.5, 10, 1, -60)
    buyTotemButton.AnchorPoint = Vector2.new(0, 1)
    buyTotemButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
    buyTotemButton.BorderSizePixel = 0
    buyTotemButton.Text = "💰 Buy Totem"
    buyTotemButton.TextColor3 = Color3.new(1, 1, 1)
    buyTotemButton.TextSize = 14
    buyTotemButton.Font = Enum.Font.SourceSansBold
    buyTotemButton.Parent = frame

    buyTotemButton.MouseButton1Click:Connect(function()
        buyTotem()
    end)

    -- ====== IMPROVED UPDATE SYSTEM (from reference) ======
    task.spawn(function()
        local lastUpdate = tick()
        local frameCount = 0

        connections.renderConnection = RunService.RenderStepped:Connect(function()
            frameCount = frameCount + 1
            local currentTime = tick()

            if currentTime - lastUpdate >= 1 then
                local fps = frameCount / (currentTime - lastUpdate)
                
                -- Safe FPS update
                pcall(function()
                    if fpsLabel and fpsLabel.Parent then
                        fpsLabel.Text = string.format("📊 FPS: %.0f", fps)
                    end
                end)
                
                -- Safe session time update
                pcall(function()
                    if sessionLabel and sessionLabel.Parent then
                        local currentUptime = math.max(0, os.time() - startTime)
                        sessionLabel.Text = "⏱️ Uptime: " .. FormatTime(currentUptime)
                    end
                end)
                
                -- Safe fishing stats update
                pcall(function()
                    if fishStatsLabel and fishStatsLabel.Parent then
                        local fishCount = math.max(0, sessionStats.totalFish)
                        fishStatsLabel.Text = "🎣 Fish Caught: " .. FormatNumber(fishCount)
                    end
                end)
                
                -- Safe coins update
                pcall(function()
                    if coinLabel and coinLabel.Parent then
                        coinLabel.Text = "💰 Coins: " .. FormatCoins(getCurrentCoins())
                    end
                end)

                -- Safe level update
                pcall(function()
                    if levelLabel and levelLabel.Parent then
                        levelLabel.Text = "⭐ " .. getCurrentLevel()
                    end
                end)
                
                -- Safe quest updates
                pcall(function() if quest1Label and quest1Label.Parent then quest1Label.Text = "🏆 Quest 1: " .. getQuestText("Label1") end end)
                pcall(function() if quest2Label and quest2Label.Parent then quest2Label.Text = "🏆 Quest 2: " .. getQuestText("Label2") end end)
                pcall(function() if quest3Label and quest3Label.Parent then quest3Label.Text = "🏆 Quest 3: " .. getQuestText("Label3") end end)
                pcall(function() if quest4Label and quest4Label.Parent then quest4Label.Text = "🏆 Quest 4: " .. getQuestText("Label4") end end)

                -- Safe status update
                pcall(function()
                    if statusLabel and statusLabel.Parent then
                        statusLabel.Text = "🤖 Auto Farm: " .. (isAutoFarmOn and "🟢 ON" or "🔴 OFF") .. 
                                         " | Auto Sell: " .. (isAutoSellOn and "🟢 ON" or "🔴 OFF") ..
                                         " | Auto Catch: " .. (isAutoCatchOn and "🟢 ON" or "🔴 OFF")
                    end
                    if extraStatusLabel and extraStatusLabel.Parent then
                        extraStatusLabel.Text = "🦈 Auto Megalodon: " .. (isAutoMegalodonOn and "🟢 ON" or "🔴 OFF") ..
                                              " | 🌤️ Auto Weather: " .. (isAutoWeatherOn and "🟢 ON" or "🔴 OFF")
                    end
                end)
                
                -- Safe Total Caught & Best Caught update
                pcall(function()
                    if titleLabel and titleLabel.Parent then
                        local currentCaught = (LocalPlayer.leaderstats and LocalPlayer.leaderstats.Caught and LocalPlayer.leaderstats.Caught.Value) or 0
                        local currentBest = (LocalPlayer.leaderstats and LocalPlayer.leaderstats["Rarest Fish"] and LocalPlayer.leaderstats["Rarest Fish"].Value) or "None"
                        titleLabel.Text = "🟢 " .. LocalPlayer.Name .. "\nTotal Caught: " .. FormatNumber(currentCaught) .. "\nBest Caught: " .. currentBest
                    end
                end)
                
                frameCount = 0
                lastUpdate = currentTime
            end
        end)
    end)
    
    -- Real-time listeners for Total Caught and Best Caught
    if LocalPlayer.leaderstats and LocalPlayer.leaderstats.Caught then
        connections.caughtConnection = LocalPlayer.leaderstats.Caught.Changed:Connect(function(newValue)
            if titleLabel then
                local currentBest = (LocalPlayer.leaderstats["Rarest Fish"] and LocalPlayer.leaderstats["Rarest Fish"].Value) or "None"
                titleLabel.Text = "🟢 " .. LocalPlayer.Name .. "\nTotal Caught: " .. newValue .. "\nBest Caught: " .. currentBest
            end
        end)
    end
    
    if LocalPlayer.leaderstats and LocalPlayer.leaderstats["Rarest Fish"] then
        connections.bestCaughtConnection = LocalPlayer.leaderstats["Rarest Fish"].Changed:Connect(function(newValue)
            if titleLabel then
                local currentCaught = (LocalPlayer.leaderstats.Caught and LocalPlayer.leaderstats.Caught.Value) or 0
                titleLabel.Text = "🟢 " .. LocalPlayer.Name .. "\nTotal Caught: " .. currentCaught .. "\nBest Caught: " .. newValue
            end
        end)
    end
    
    whiteScreenGui.Parent = game:GetService("CoreGui")
end

local function removeWhiteScreen()
    if whiteScreenGui then
        whiteScreenGui:Destroy()
        whiteScreenGui = nil
    end
    
    if connections.renderConnection then
        connections.renderConnection:Disconnect()
        connections.renderConnection = nil
    end
    
    if connections.caughtConnection then
        connections.caughtConnection:Disconnect()
        connections.caughtConnection = nil
    end
    
    if connections.bestCaughtConnection then
        connections.bestCaughtConnection:Disconnect()
        connections.bestCaughtConnection = nil
    end
end

function enableGPUSaver()
    if gpuSaverEnabled then return end
    gpuSaverEnabled = true

    print("[VRAM Optimizer] 🔄 Enabling GPU Saver with VRAM optimizations...")

    -- ====== V3.3: RE-APPLY ALL VRAM OPTIMIZATIONS ======
    -- Run cleanup and performance optimizations again to ensure paths are removed
    pcall(ultimatePerformance)
    pcall(cleanupEnvironment)

    -- V3.3: Re-apply material & texture optimizations
    print("[VRAM Optimizer] 🔁 Re-applying VRAM optimizations...")
    pcall(optimizeMaterials)
    pcall(removeTextures)
    pcall(optimizeMeshes)
    pcall(destroyParticlesAndEffects)

    -- V3.3: Re-disable 3D rendering
    task.wait(0.5)
    pcall(disable3DRendering)

    -- Store original settings
    originalSettings.GlobalShadows = Lighting.GlobalShadows
    originalSettings.FogEnd = Lighting.FogEnd
    originalSettings.Brightness = Lighting.Brightness
    originalSettings.QualityLevel = settings().Rendering.QualityLevel

    -- Apply GPU saving settings
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1
        Lighting.Brightness = 0

        -- This loop is likely redundant since ultimatePerformance() clears lighting children, but it's safe to keep.
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then
                v.Enabled = false
            end
        end

        pcall(function() setfpscap(GPU_FPS_LIMIT) end) -- Limit FPS based on GPU_FPS_LIMIT
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
        -- workspace.CurrentCamera.FieldOfView is not set because cleanupEnvironment() destroys the camera.
    end)

    -- Create FPS cap monitor to ensure it stays at GPU_FPS_LIMIT
    if fpsCapConnection then
        fpsCapConnection:Disconnect()
        fpsCapConnection = nil
    end

    fpsCapConnection = RunService.Heartbeat:Connect(function()
        if gpuSaverEnabled then
            pcall(function()
                if setfpscap then
                    setfpscap(GPU_FPS_LIMIT)
                end
            end)
        end
    end)

    createWhiteScreen()

    -- Update toggle if available
    if gpuSaverToggle and not isApplyingConfig then
        gpuSaverToggle:UpdateToggle(nil, true)
    end

    print("[VRAM Optimizer] ✅ GPU Saver enabled with all VRAM optimizations active")
end

function disableGPUSaver()
    if not gpuSaverEnabled then return end
    gpuSaverEnabled = false

    print("[VRAM Optimizer] 🔄 Disabling GPU Saver and restoring 3D rendering...")

    -- Disconnect FPS cap monitor
    if fpsCapConnection then
        fpsCapConnection:Disconnect()
        fpsCapConnection = nil
    end

    -- V3.3: Re-enable 3D rendering first
    enable3DRendering()

    -- Restore settings
    pcall(function()
        if originalSettings.QualityLevel then
            settings().Rendering.QualityLevel = originalSettings.QualityLevel
        end

        Lighting.GlobalShadows = originalSettings.GlobalShadows or true
        Lighting.FogEnd = originalSettings.FogEnd or 100000
        Lighting.Brightness = originalSettings.Brightness or 1

        -- The lighting children were deleted, so re-enabling them is not possible.
        -- This part of the restoration is omitted.

        pcall(function() setfpscap(0) end) -- Remove FPS limit
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)

        -- Check if camera exists before restoring FieldOfView, as it may have been destroyed.
        if workspace.CurrentCamera then
            workspace.CurrentCamera.FieldOfView = 70
        end
    end)

    removeWhiteScreen()

    -- Update toggle if available
    if gpuSaverToggle and not isApplyingConfig then
        gpuSaverToggle:UpdateToggle(nil, false)
    end

    print("[VRAM Optimizer] ✅ GPU Saver disabled, 3D rendering restored")
end

-- ====== FISH CAUGHT EVENT HANDLER ======
local function setupFishTracking()

    task.spawn(function()
        task.wait(2)
        if LocalPlayer.leaderstats and LocalPlayer.leaderstats.Caught then
            local lastCaught = LocalPlayer.leaderstats.Caught.Value

            LocalPlayer.leaderstats.Caught.Changed:Connect(function(newValue)
                local increase = newValue - lastCaught
                if increase > 0 then
                    sessionStats.totalFish = sessionStats.totalFish + increase
                end
                lastCaught = newValue
            end)
        end
    end)
end

-- ====== STUCK DETECTION REMOVED ======
-- Removed entire stuck detection system to reduce complexity

-- Call this function
setupFishTracking()

local teleportLocations = {
    { Name = "Kohana Volcano", CFrame = CFrame.new(-572.879456, 22.4521465, 148.355331, -0.995764792, -6.67705606e-08, 0.0919371247, -5.74611505e-08, 1, 1.03905414e-07, -0.0919371247, 9.81825394e-08, -0.995764792) },
    { Name = "Sisyphus Statue",  CFrame = CFrame.new(1831.71362, 6.62499952, -299.279175, 0.213522509, 1.25553285e-07, -0.976938128, -4.32026184e-08, 1, 1.19074642e-07, 0.976938128, 1.67811702e-08, 0.213522509) },
    { Name = "Coral Reefs",  CFrame = CFrame.new(-3114.78198, 1.32066584, 2237.52295, -0.304758579, 1.6556676e-08, -0.952429652, -8.50574935e-08, 1, 4.46003305e-08, 0.952429652, 9.46036067e-08, -0.304758579) },
    { Name = "Esoteric Depths",  CFrame = CFrame.new(3248.37109, -1301.53027, 1403.82727, -0.920208454, 7.76270355e-08, 0.391428679, 4.56261056e-08, 1, -9.10549289e-08, -0.391428679, -6.5930152e-08, -0.920208454) },
    { Name = "Crater Island",  CFrame = CFrame.new(1016.49072, 20.0919304, 5069.27295, 0.838976264, 3.30379857e-09, -0.544168055, 2.63538391e-09, 1, 1.01344115e-08, 0.544168055, -9.93662219e-09, 0.838976264) },
    { Name = "Spawn",  CFrame = CFrame.new(45.2788086, 252.562927, 2987.10913, 1, 0, 0, 0, 1, 0, 0, 0, 1) },
    { Name = "Lost Isle",  CFrame = CFrame.new(-3618.15698, 240.836655, -1317.45801, 1, 0, 0, 0, 1, 0, 0, 0, 1) },
    { Name = "Weather Machine",  CFrame = CFrame.new(-1488.51196, 83.1732635, 1876.30298, 1, 0, 0, 0, 1, 0, 0, 0, 1) },
    { Name = "Tropical Grove",  CFrame = CFrame.new(-2095.34106, 197.199997, 3718.08008) },
    { Name = "Treasure Room",  CFrame = CFrame.new(-3606.34985, -266.57373, -1580.97339, 0.998743415, 1.12141152e-13, -0.0501160324, -1.56847693e-13, 1, -8.88127842e-13, 0.0501160324, 8.94872392e-13, 0.998743415) },
    { Name = "Kohana",  CFrame = CFrame.new(-663.904236, 3.04580712, 718.796875, -0.100799225, -2.14183729e-08, -0.994906783, -1.12300391e-08, 1, -2.03902459e-08, 0.994906783, 9.11752096e-09, -0.100799225) },
    { Name = "Underground Cellar", CFrame = CFrame.new(2108.71606, -94.1875076, -709.647827, 0.508109629, 1.18704779e-08, -0.861292422, -1.60964764e-09, 1, 1.28325759e-08, 0.861292422, -5.13397813e-09, 0.508109629) },
    { Name = "Ancient Jungle", CFrame = CFrame.new(1831.71362, 6.62499952, -299.279175, 0.213522509, 1.25553285e-07, -0.976938128, -4.32026184e-08, 1, 1.19074642e-07, 0.976938128, 1.67811702e-08, 0.213522509) },
    { Name = "Sacred Temple", CFrame = CFrame.new(1466.92151, -21.8750591, -622.835693, -0.764787138, 8.14444334e-09, 0.644283056, 2.31097452e-08, 1, 1.4791004e-08, -0.644283056, 2.6201187e-08, -0.764787138) }
}

local function teleportToNamedLocation(targetName)
    if not targetName then
        return
    end

    if targetName == "Sisyphus State" then
        targetName = "Sisyphus Statue"
    end

    pcall(function()
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not rootPart then
            return
        end

        for _, location in ipairs(teleportLocations) do
            if location.Name == targetName and location.CFrame then
                rootPart.CFrame = location.CFrame
                break
            end
        end
    end)
end

local PRESET_DELAY = 0.5
local presetActionLock = false

local function runPresetSequence(steps)
    if type(steps) ~= "table" or #steps == 0 then
        return
    end

    while presetActionLock do
        task.wait(0.05)
    end

    presetActionLock = true
    isApplyingConfig = true

    local success, err = pcall(function()
        for index, step in ipairs(steps) do
            step()
            if index < #steps then
                task.wait(PRESET_DELAY)
            end
        end
    end)

    isApplyingConfig = false
    syncConfigFromStates()
    presetActionLock = false

    if not success then
        warn("[AutoFish] Preset sequence error:", err)
    end
end

local function enablePreset(presetKey, locationName)
    task.spawn(function()
        local steps = {}

        if config.activePreset and config.activePreset ~= "none" and config.activePreset ~= presetKey then
            table.insert(steps, function() 
                if autoMegalodonToggle then 
                    autoMegalodonToggle:UpdateToggle(nil, false)
                end
            end)
            table.insert(steps, function() 
                if autoWeatherToggle then 
                    autoWeatherToggle:UpdateToggle(nil, false)
                end
            end)
            table.insert(steps, function() 
                if autoCatchToggle then 
                    autoCatchToggle:UpdateToggle(nil, false)
                end
            end)
            table.insert(steps, function() 
                if autoSellToggle then 
                    autoSellToggle:UpdateToggle(nil, false)
                end
            end)
            table.insert(steps, function() 
                if autoFarmToggle then 
                    autoFarmToggle:UpdateToggle(nil, false)
                end
            end)
        end

        table.insert(steps, function() 
            if autoFarmToggle then 
                autoFarmToggle:UpdateToggle(nil, true)
            end
        end)
        table.insert(steps, function() 
            if autoSellToggle then 
                autoSellToggle:UpdateToggle(nil, true)
            end
        end)
        table.insert(steps, function() 
            if autoCatchToggle then 
                autoCatchToggle:UpdateToggle(nil, true)
            end
        end)

        -- Only enable weather and megalodon for auto1 and auto2, not auto3
        if presetKey ~= "auto3" then
            table.insert(steps, function() 
                if autoWeatherToggle then 
                    autoWeatherToggle:UpdateToggle(nil, true)
                end
            end)
            table.insert(steps, function() 
                if autoMegalodonToggle then 
                    autoMegalodonToggle:UpdateToggle(nil, true)
                end
            end)
        end

        table.insert(steps, function()
            enableGPUSaver()
        end)

        -- Set custom delays for each preset
        table.insert(steps, function()
            setDelaysForPreset(presetKey)
        end)

        runPresetSequence(steps)

        if presetKey == "auto1" then
            isAutoPreset1On = true
            isAutoPreset2On = false
            isAutoPreset3On = false
        elseif presetKey == "auto2" then
            isAutoPreset1On = false
            isAutoPreset2On = true
            isAutoPreset3On = false
        elseif presetKey == "auto3" then
            isAutoPreset1On = false
            isAutoPreset2On = false
            isAutoPreset3On = true
        else
            isAutoPreset1On = false
            isAutoPreset2On = true
            isAutoPreset3On = false
        end

        config.activePreset = presetKey
        saveConfig()
        teleportToNamedLocation(locationName)
    end)
end

local function disablePreset(presetKey)
    task.spawn(function()
        if config.activePreset ~= presetKey then
            if presetKey == "auto1" then
                isAutoPreset1On = false
            elseif presetKey == "auto2" then
                isAutoPreset2On = false
            elseif presetKey == "auto3" then
                isAutoPreset3On = false
            end
            return
        end

        local steps = {
            function() 
                if autoMegalodonToggle then 
                    autoMegalodonToggle:UpdateToggle(nil, false)
                end
            end,
            function() 
                if autoWeatherToggle then 
                    autoWeatherToggle:UpdateToggle(nil, false)
                end
            end,
            function() 
                if autoCatchToggle then 
                    autoCatchToggle:UpdateToggle(nil, false)
                end
            end,
            function() 
                if autoSellToggle then 
                    autoSellToggle:UpdateToggle(nil, false)
                end
            end,
            function() 
                if autoFarmToggle then 
                    autoFarmToggle:UpdateToggle(nil, false)
                end
            end,
            function() 
                disableGPUSaver()
            end,
        }

        -- Reset delays when disabling preset
        table.insert(steps, function()
            -- Reset to default delays
            if autoFishMainSlider then
                autoFishMainSlider:Set(0.9)
            else
                setAutoFishMainDelay(0.9)
            end
            if autoCatchSlider then
                autoCatchSlider:Set(0.2)
            else
                setAutoCatchDelay(0.2)
            end
        end)

        runPresetSequence(steps)

        if presetKey == "auto1" then
            isAutoPreset1On = false
        elseif presetKey == "auto2" then
            isAutoPreset2On = false
        elseif presetKey == "auto3" then
            isAutoPreset3On = false
        else
            isAutoPreset2On = false
        end

        config.activePreset = "none"
        saveConfig()
    end)
end


-- ====== DAFTAR IDS ====== 
local WeatherIDs = {"Cloudy", "Storm","Wind"}


-- ====== CORE FUNCTIONS ====== 
local function chargeFishingRod()
    pcall(function()
        if chargeEvent then
            chargeEvent:InvokeServer(1755848498.4834)
            task.wait(chargeFishingDelay)
        end
        if requestMinigameEvent then
            requestMinigameEvent:InvokeServer(1.2854545116425, 1)
        end
    end)
end

local function cancelFishing()
    pcall(function()
        if cancelFishingEvent then
            cancelFishingEvent:InvokeServer()
        end
    end)
end

local function performAutoCatch()
    pcall(function()
        if fishingEvent then
            fishingEvent:FireServer()
        end
    end)
end

local function equipRod()
    pcall(function() 
        if equipEvent then 
            equipEvent:FireServer(1)
        end 
    end)
end

local function unequipRod()
    pcall(function() 
        if unequipEvent then 
            unequipEvent:FireServer()
        end 
    end)
end


-- ====== MEGALODON HUNT FUNCTIONS (BODYVELOCITY LOCK) ======
local megalodonLockedCFrame = nil
local megalodonPositionLocked = false
local megalodonBodyVelocity = nil
local megalodonBodyGyro = nil
local megalodonCurrentEventPos = nil

function teleportToMegalodon(pos, isEvent)
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not root or not hum then return end

    -- Calculate teleport position
    local tPos = pos
    if type(pos) == "userdata" and pos.X then
        tPos = pos + Vector3.new(0, 5, 0)
    elseif type(pos) == "userdata" and pos.Position then
        tPos = pos.Position + Vector3.new(0, 5, 0)
    end

    if isEvent then
        -- Check if this is the same event position (avoid re-teleporting)
        if megalodonCurrentEventPos and (tPos - megalodonCurrentEventPos).Magnitude < 5 then
            -- Same event, already locked, do nothing
            return
        end

        -- New event or first time, setup lock
        megalodonCurrentEventPos = tPos

        -- Clean up old lock if exists
        disableMegalodonLock()

        -- Teleport to position (8 studs above water to avoid invisible blocks)
        local finalPos = tPos + Vector3.new(0, 8, 0)
        root.CFrame = CFrame.new(finalPos)
        task.wait(0.2)

        -- Store locked position
        megalodonLockedCFrame = root.CFrame
        megalodonPositionLocked = true
        megalodonLockActive = true

        -- Create BodyVelocity to lock position (smooth, no shaking)
        megalodonBodyVelocity = Instance.new("BodyVelocity")
        megalodonBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        megalodonBodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        megalodonBodyVelocity.P = 10000
        megalodonBodyVelocity.Parent = root

        -- Create BodyGyro to prevent rotation
        megalodonBodyGyro = Instance.new("BodyGyro")
        megalodonBodyGyro.CFrame = megalodonLockedCFrame
        megalodonBodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
        megalodonBodyGyro.P = 10000
        megalodonBodyGyro.Parent = root

        -- Minimal position correction (only when very far)
        megalodonLockConnection = RunService.Heartbeat:Connect(function()
            if not root or not root.Parent or not megalodonLockActive then
                if megalodonLockConnection then
                    megalodonLockConnection:Disconnect()
                    megalodonLockConnection = nil
                end
                return
            end

            -- Only correct if drifted extremely far (> 15 studs)
            -- BodyVelocity handles all normal drifts
            if (root.Position - megalodonLockedCFrame.Position).Magnitude > 15 then
                root.CFrame = megalodonLockedCFrame
                if megalodonBodyVelocity then
                    megalodonBodyVelocity.Velocity = Vector3.new(0, 0, 0)
                end
            end
        end)
    else
        -- Manual teleport without lock
        root.CFrame = CFrame.new(tPos)
    end
end

function disableMegalodonLock()
    megalodonLockActive = false
    megalodonLockedCFrame = nil
    megalodonPositionLocked = false
    megalodonCurrentEventPos = nil

    if megalodonLockConnection then
        megalodonLockConnection:Disconnect()
        megalodonLockConnection = nil
    end

    -- Remove BodyVelocity and BodyGyro
    if megalodonBodyVelocity then
        megalodonBodyVelocity:Destroy()
        megalodonBodyVelocity = nil
    end
    if megalodonBodyGyro then
        megalodonBodyGyro:Destroy()
        megalodonBodyGyro = nil
    end
end

local function formatDuration(seconds)
    if not seconds or seconds <= 0 then
        return "Unavailable"
    end

    seconds = math.floor(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local remainingSeconds = seconds % 60

    if hours > 0 then
        return string.format("%dh %dm %ds", hours, minutes, remainingSeconds)
    elseif minutes > 0 then
        return string.format("%dm %ds", minutes, remainingSeconds)
    else
        return string.format("%ds", remainingSeconds)
    end
end

local function resumeFarmingAfterMegalodon(previousAutoFarmState)
    task.spawn(function()
        task.wait(1) -- Wait a moment before resuming

        -- Teleport back to original farming location
        local farmLocation = config.teleportLocation or "Sisyphus Statue"
        teleportToNamedLocation(farmLocation)
        task.wait(2)

        -- Check which preset was active
        local activePreset = config.activePreset

        if activePreset == "auto1" then
            -- Re-activate Auto 1 (Crater Island)
            if autoPreset1Toggle then
                autoPreset1Toggle:UpdateToggle(nil, false)
                task.wait(0.5)
                autoPreset1Toggle:UpdateToggle(nil, true)
            end
        elseif activePreset == "auto2" then
            -- Re-activate Auto 2 (Sisyphus)
            if autoPreset2Toggle then
                autoPreset2Toggle:UpdateToggle(nil, false)
                task.wait(0.5)
                autoPreset2Toggle:UpdateToggle(nil, true)
            end
        elseif activePreset == "auto3" then
            -- Re-activate Auto 3 (Kohana)
            if autoPreset3Toggle then
                autoPreset3Toggle:UpdateToggle(nil, false)
                task.wait(0.5)
                autoPreset3Toggle:UpdateToggle(nil, true)
            end
        else
            -- No preset active, just resume farming if it was on
            local shouldResume = previousAutoFarmState
            if shouldResume == nil then
                shouldResume = config.autoFarm
            end

            if shouldResume then
                if not isAutoFarmOn then
                    setAutoFarm(true)
                else
                    equipRod()
                end
            end
        end
    end)
end

-- ====== MEGALODON WEBHOOK ====== 
local lastWebhookTime = 0
local WEBHOOK_COOLDOWN = 15 -- 15 seconds cooldown between webhooks to prevent rate limiting
local webhookRetryDelay = 5 -- Base retry delay in seconds
local maxRetryAttempts = 3

-- ====== UNIFIED WEBHOOK CONFIGURATION ======
-- Use webhook2 from main.lua if available, otherwise use empty fallback
local UNIFIED_WEBHOOK_URL = type(webhook2) == "string" and webhook2 or ""

-- ====== UNIFIED WEBHOOK FUNCTION ======
local function sendUnifiedWebhook(webhookType, data)
    -- Check if webhook URL is configured
    if not UNIFIED_WEBHOOK_URL or UNIFIED_WEBHOOK_URL == "" then
        warn('[Webhook] URL not configured! Please set UNIFIED_WEBHOOK_URL variable.')
        return
    end

    -- Rate limiting check
    local currentTime = tick()
    if currentTime - lastWebhookTime < WEBHOOK_COOLDOWN then
        return
    end

    local embed = {}

    -- Configure embed based on webhook type
    if webhookType == "megalodon_missing" then
        embed = {
            title = '[Megalodon] Event Missing',
            description = 'No Megalodon Hunt props detected in this server.',
            color = 16711680, -- Red
            fields = {
                { name = "👤 Player", value = (player.DisplayName or player.Name or "Unknown"), inline = true },
                { name = "🕒 Time", value = os.date("%H:%M:%S"), inline = true }
            },
            footer = { text = 'Megalodon Watch - Auto Fish' }
        }
    elseif webhookType == "megalodon_ended" then
        local endedAt = data and data.endedAt or os.time()
        local startedAt = data and data.startedAt or 0
        local duration = data and data.duration
        if (not duration or duration <= 0) and startedAt > 0 then
            duration = math.max(0, endedAt - startedAt)
        end

        embed = {
            title = '[Megalodon] Event Ended',
            description = 'Megalodon Hunt props removed. Resuming farming routine.',
            color = 3447003, -- Blue
            fields = {
                { name = "Player", value = (player.DisplayName or player.Name or "Unknown"), inline = true },
                { name = "Ended At", value = os.date("%H:%M:%S", endedAt), inline = true },
                { name = "Duration", value = formatDuration(duration), inline = true },
            },
            footer = { text = 'Megalodon Watch - Auto Fish' }
        }

    elseif webhookType == "fish_found" then
        embed = {
            title = "🎣 SECRET Fish Found",
            description = data.description or "Fish detected in inventory",
            color = 3066993, -- Blue-green
            fields = {
                { name = "🕒 Waktu",  value = os.date("%H:%M:%S"), inline = true },
                { name = "👤 Player", value = player.DisplayName or player.Name or "Unknown", inline = true },
                { name = "📦 Total (whitelist)", value = tostring(data.totalWhitelistCount or 0) .. " fish", inline = true },
            },
            footer = { text = "Inventory Notifier • Auto Fish" }
        }
    else
        warn('[Webhook] Unknown webhook type: ' .. tostring(webhookType))
        return
    end

    local body = HttpService:JSONEncode({ embeds = {embed} })

    -- Send webhook with exponential backoff retry logic
    task.spawn(function()
        local attempt = 1
        local success = false

        while attempt <= maxRetryAttempts and not success do
            local currentRetryDelay = webhookRetryDelay * (2 ^ (attempt - 1)) -- Exponential backoff

            if attempt > 1 then
                task.wait(currentRetryDelay)
            end

            success, err = pcall(function()
                if syn and syn.request then
                    syn.request({ Url=UNIFIED_WEBHOOK_URL, Method="POST", Headers={["Content-Type"]="application/json"}, Body=body })
                elseif http_request then
                    http_request({ Url=UNIFIED_WEBHOOK_URL, Method="POST", Headers={["Content-Type"]="application/json"}, Body=body })
                elseif fluxus and fluxus.request then
                    fluxus.request({ Url=UNIFIED_WEBHOOK_URL, Method="POST", Headers={["Content-Type"]="application/json"}, Body=body })
                elseif request then
                    request({ Url=UNIFIED_WEBHOOK_URL, Method="POST", Headers={["Content-Type"]="application/json"}, Body=body })
                else
                    error("Executor tidak support HTTP requests")
                end
            end)

            if success then
                lastWebhookTime = tick()
                break
            else
                warn('[Webhook] ' .. webhookType .. ' attempt ' .. attempt .. ' failed: ' .. tostring(err))

                -- Handle specific rate limiting errors
                if string.find(tostring(err):lower(), "429") or string.find(tostring(err):lower(), "rate") then
                    lastWebhookTime = tick() + 60 -- Block webhooks for 60 seconds on rate limit
                    task.wait(60) -- Wait longer for rate limit recovery
                    break -- Don't retry immediately on rate limit
                elseif string.find(tostring(err):lower(), "network") or string.find(tostring(err):lower(), "timeout") then
                    print('[Webhook] Network error detected, will retry...')
                end

                attempt = attempt + 1
            end
        end

        if not success then
            warn('[Webhook] All ' .. webhookType .. ' attempts failed')
        end
    end)
end

-- Legacy function for compatibility
local sendMegalodonEventWebhook = function(status, data)
    if status == "missing" then
        sendUnifiedWebhook("megalodon_missing", data)
    elseif status == "ended" then
        sendUnifiedWebhook("megalodon_ended", data)
    end
end

local function autoDetectMegalodon()
    local eventFound = false
    local eventPosition = nil
    local debugMode = false -- Set to true for troubleshooting

    -- New, more robust path detection to handle multiple "Props" children
    pcall(function()
        local menuRings = workspace:FindFirstChild("!!! MENU RINGS")
        if menuRings then
            -- Iterate through all children of "!!! MENU RINGS" to find the correct "Props" folder
            for _, propsFolder in ipairs(menuRings:GetChildren()) do
                if propsFolder.Name == "Props" then
                    local huntFolder = propsFolder:FindFirstChild("Megalodon Hunt")
                    if huntFolder then
                        local colorPart = huntFolder:FindFirstChild("Color")
                        if colorPart and colorPart.Position then
                            eventPosition = colorPart.Position
                            eventFound = true
                            break -- Exit the loop once found
                        end
                    end
                end
            end
        end
    end)

    -- Fallback to old detection method if new one fails
    if not eventFound then
        if debugMode then print("[Megalodon Debug] New path failed, trying old detection method...") end
        
        -- Search for Megalodon event directly in Workspace (handle multiple Props folders)
        for _, child in ipairs(workspace:GetChildren()) do
            if string.lower(child.Name) == "props" then

                local megalodonHunt = child:FindFirstChild("Megalodon Hunt") or
                                    child:FindFirstChild("megalodon hunt") or
                                    child:FindFirstChild("Megalodon_Hunt") or
                                    child:FindFirstChild("megalodon_hunt") or
                                    child:FindFirstChild("MegalodonHunt") or
                                    child:FindFirstChild("megalodonh hunt")

                if megalodonHunt and megalodonHunt:FindFirstChild("Color") and megalodonHunt.Color.Position then
                    eventPosition = megalodonHunt.Color.Position
                    eventFound = true
                    break
                end
            end
        end
    end
    
    -- Fallback 2: Deeper search if still not found
    if not eventFound then
        if debugMode then print("[Megalodon Debug] Standard fallback failed, trying deep search...") end
        for _, child in ipairs(workspace:GetChildren()) do
            if string.lower(child.Name) == "props" then
                for _, subChild in ipairs(child:GetChildren()) do
                    if string.find(string.lower(subChild.Name), "megalodon") then
                        if subChild:FindFirstChild("Color") and subChild.Color.Position then
                            eventPosition = subChild.Color.Position
                            eventFound = true
                            break
                        end
                    end
                end
                if eventFound then break end
            end
        end
    end

    if eventFound and eventPosition then
        -- Mark event as active if not already
        if not megalodonEventActive then
            megalodonEventActive = true
            megalodonMissingAlertSent = false
            megalodonEventEndAlertSent = false
            megalodonPreEventFarmState = isAutoFarmOn
            megalodonEventStartedAt = os.time()
        end

        teleportToMegalodon(eventPosition, true)
    else
        -- Handle event end or missing props
        local wasActive = megalodonEventActive
        if wasActive then
            megalodonEventActive = false
            disableMegalodonLock()
        end

        if wasActive then
            if not megalodonEventEndAlertSent then
                megalodonEventEndAlertSent = true
                megalodonMissingAlertSent = true

                local eventEndedAt = os.time()
                local duration = nil
                if megalodonEventStartedAt and megalodonEventStartedAt > 0 then
                    duration = math.max(0, eventEndedAt - megalodonEventStartedAt)
                end

                sendMegalodonEventWebhook("ended", {
                    endedAt = eventEndedAt,
                    startedAt = megalodonEventStartedAt,
                    duration = duration,
                })
            end

            megalodonEventStartedAt = 0
            resumeFarmingAfterMegalodon(megalodonPreEventFarmState)
            megalodonPreEventFarmState = nil
        elseif not megalodonMissingAlertSent then
            -- Send webhook about missing event only once per session
            megalodonMissingAlertSent = true
            sendMegalodonEventWebhook("missing")
        end
    end
end

local function setAutoMegalodon(state)
    isAutoMegalodonOn = state
    updateConfigField("autoMegalodon", state)
    if not state then
        -- Reset megalodon state
        disableMegalodonLock()
        megalodonMissingAlertSent = false
        megalodonEventActive = false
        megalodonEventStartedAt = 0
        megalodonEventEndAlertSent = false
        megalodonPreEventFarmState = nil
    end
end

-- ====== CONNECTION STATUS WEBHOOK SYSTEM ======
-- Webhook khusus untuk status connect/disconnect
-- PENTING: Pastikan webhook3 dan discordid sudah dikonfigurasi di main.lua sebelum menjalankan script ini!
-- Contoh konfigurasi di main.lua:
-- webhook3 = "https://discord.com/api/webhooks/YOUR_WEBHOOK_ID/YOUR_WEBHOOK_TOKEN"
-- discordid = "123456789012345678"  -- Discord User ID (18 digit number)
local CONNECTION_WEBHOOK_URL = type(webhook3) == "string" and webhook3 or ""  -- URL webhook khusus untuk status koneksi

local hasSentDisconnectWebhook = false  -- Flag to avoid sending multiple notifications
local PING_THRESHOLD = 1000  -- ms, ping monitoring (webhook disabled, console log only)
local FREEZE_THRESHOLD = 3  -- seconds, if delta > this = game freeze

-- DISCORD USER ID untuk tag saat disconnect (ganti dengan ID Discord Anda)
local DISCORD_USER_ID = type(discordid) == "string" and discordid or "701247227959574567"  -- Fallback jika discordid tidak terdefinisi

-- QUEUE SYSTEM untuk multiple accounts (mencegah rate limiting)
local webhookQueue = {}
local isProcessingQueue = false
local WEBHOOK_DELAY = 2  -- seconds between webhook sends
local lastWebhookSent = 0

-- ====== MESSAGE EDITING SYSTEM ======
-- Online Status System - REMOVED to save memory
-- Old variables removed:
-- - MESSAGE_ID_STORAGE
-- - ONLINE_STATUS_UPDATE_INTERVAL
-- - lastOnlineStatusUpdate
-- - isOnlineStatusActive
-- - onlineStatusMessageId

-- Compact message storage functions
function saveMessageId(accountId, messageId)
    MESSAGE_ID_STORAGE = MESSAGE_ID_STORAGE or {}
    MESSAGE_ID_STORAGE[accountId] = MESSAGE_ID_STORAGE[accountId] or {}
    MESSAGE_ID_STORAGE[accountId].statusMessageId = messageId
    if writefile and ensureConfigFolder() then
        pcall(function()
            writefile(CONFIG_FOLDER .. "/message_ids_" .. accountId .. ".json",
                HttpService:JSONEncode({statusMessageId = messageId, lastUpdate = os.time(), playerName = LocalPlayer.Name}))
        end)
    end
end

function loadMessageId(accountId)
    if not readfile or not isfile then return nil end
    local file = CONFIG_FOLDER .. "/message_ids_" .. accountId .. ".json"
    if not isfile(file) then return nil end
    local success, result = pcall(function()
        return HttpService:JSONDecode(readfile(file)).statusMessageId
    end)
    if success and result then
        MESSAGE_ID_STORAGE[accountId] = MESSAGE_ID_STORAGE[accountId] or {}
        MESSAGE_ID_STORAGE[accountId].statusMessageId = result
        return result
    end
    return nil
end

function getStoredMessageId(accountId)
    return (MESSAGE_ID_STORAGE[accountId] and MESSAGE_ID_STORAGE[accountId].statusMessageId) or loadMessageId(accountId)
end

-- ====== RECONNECT DETECTION SYSTEM ======
local lastSessionId = nil
local lastDisconnectTime = nil
local RECONNECT_THRESHOLD = 60  -- seconds, if reconnect within this time = quick reconnect
local NEW_SESSION_THRESHOLD = 60  -- seconds, if offline > 1 minute = treat as new connection

-- Compact Discord message edit function
function editDiscordMessage(messageId, embed, content)
    if not CONNECTION_WEBHOOK_URL or CONNECTION_WEBHOOK_URL == "" or not messageId then
        return false, "Invalid config"
    end

    local webhookId, webhookToken = CONNECTION_WEBHOOK_URL:match("https://discord%.com/api/webhooks/(%d+)/([%w%-_]+)")
    if not webhookId or not webhookToken then return false, "Invalid URL" end

    local payload = { embeds = {embed} }
    if content and content ~= "" then
        payload.content = content
        payload.allowed_mentions = {users = {tostring(DISCORD_USER_ID)}}
    end

    local success, err = pcall(function()
        local req = syn and syn.request or http_request or (fluxus and fluxus.request) or request
        if not req then error("No HTTP support") end
        req({
            Url = string.format("https://discord.com/api/webhooks/%s/%s/messages/%s", webhookId, webhookToken, messageId),
            Method = "PATCH",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(payload)
        })
    end)
    return success, err
end

-- Compact new message sender
function sendNewStatusMessage(embed, content)
    if not CONNECTION_WEBHOOK_URL or CONNECTION_WEBHOOK_URL == "" then
        return nil, "No webhook URL"
    end

    local payload = { embeds = {embed}, wait = true }
    if content and content ~= "" then
        payload.content = content
        payload.allowed_mentions = {users = {tostring(DISCORD_USER_ID)}}
    end

    local success, response = pcall(function()
        local req = syn and syn.request or http_request or (fluxus and fluxus.request) or request
        if not req then error("No HTTP support") end
        return req({
            Url = CONNECTION_WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(payload)
        })
    end)

    if success and response and response.Body then
        local data = HttpService:JSONDecode(response.Body)
        if data and data.id then return data.id, nil end
    end
    return nil, response or "Send failed"
end

-- Compact online status updater
function updateOnlineStatus()
    local accountId = tostring(LocalPlayer.UserId)
    local uptime = os.time() - startTime
    local stats = LocalPlayer.leaderstats
    local fishCount = (stats and stats.Caught and stats.Caught.Value) or 0
    local bestFish = (stats and stats["Rarest Fish"] and stats["Rarest Fish"].Value) or "None"

    local embed = {
        title = "🟢 " .. (LocalPlayer.DisplayName or LocalPlayer.Name) .. " - ONLINE",
        description = "**Status**: Auto Fish Active 🎣",
        color = 65280,
        fields = {
            { name = "⏰ Last Update", value = os.date("%H:%M:%S"), inline = true },
            { name = "⌛ Uptime", value = FormatTime(uptime), inline = true },
            { name = "🐠 Total Fish", value = FormatNumber(fishCount), inline = true },
            { name = "🏆 Best Fish", value = bestFish, inline = true },
            { name = "💰 Coins", value = FormatNumber(getCurrentCoins()), inline = true },
            { name = "⭐ Level", value = getCurrentLevel(), inline = true },
        },
        footer = { text = "Auto Fish Status • Updates every " .. ONLINE_STATUS_UPDATE_INTERVAL .. "s" },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
    }

    local messageId = getStoredMessageId(accountId)
    if messageId then
        local success = editDiscordMessage(messageId, embed, "")
        if success then
            return true
        end
        MESSAGE_ID_STORAGE[accountId] = nil
    end

    messageId = sendNewStatusMessage(embed, "")
    if messageId then
        saveMessageId(accountId, messageId)
        onlineStatusMessageId = messageId
        return true
    end
    return false
end

-- Fungsi untuk mengirim status koneksi ke webhook khusus (modified)
local function sendConnectionStatusWebhook(status, reason)

    -- Check if webhook URL is configured
    if not CONNECTION_WEBHOOK_URL or CONNECTION_WEBHOOK_URL == "" then
        warn('[Connection Status] Webhook URL not configured! Please set CONNECTION_WEBHOOK_URL variable.')
        return
    end


    local embed = {}

    -- NOTE: "connected" status removed to reduce webhook spam
    -- Only "reconnected" and "disconnected" will send notifications
    if status == "reconnected" then
        embed = {
            title = "🔄 Player Reconnected",
            description = reason or "Player has successfully reconnected to the server",
            color = 3066993, -- Blue-green
            fields = {
                { name = "👤 Player", value = LocalPlayer.DisplayName or LocalPlayer.Name or "Unknown", inline = true },
                { name = "🕒 Time", value = os.date("%H:%M:%S"), inline = true },
                { name = "🔄 Reconnect Info", value = reason or "Reconnection detected", inline = false },
                { name = "📱 Status", value = "Auto Fish Resumed", inline = true }
            },
            footer = { text = "Reconnect Monitor • Auto Fish Script" },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
        }
    elseif status == "disconnected" then
        embed = {
            title = "🔴 Player Disconnected",
            description = reason or "Player has disconnected from the server",
            color = 16711680, -- Red
            fields = {
                { name = "👤 Player", value = LocalPlayer.DisplayName or LocalPlayer.Name or "Unknown", inline = true },
                { name = "🕒 Time", value = os.date("%H:%M:%S"), inline = true },
                { name = "🔌 Reason", value = reason or "Unknown", inline = false },
                { name = "⏱️ Session Duration", value = FormatTime(os.time() - startTime), inline = true },
                { name = "📱 Game", value = "🐠 Fish It", inline = true },
                { name = "🆔 User ID", value = tostring(LocalPlayer.UserId), inline = true }
            },
            footer = { text = "Disconnect Alert • Auto Fish Script" },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
        }
    else
        warn('[Connection Status] Unknown status type: ' .. tostring(status))
        return
    end

    -- Prepare payload with mentions for disconnect and reconnect status
    local payload = { embeds = {embed} }

    -- Prepare content with Discord mentions
    local userIdStr = tostring(DISCORD_USER_ID)
    local playerName = LocalPlayer.DisplayName or LocalPlayer.Name or "Player"

    if status == "disconnected" then
        -- Always include mention for disconnect notifications
        payload.content = "<@" .. userIdStr .. "> 🔴 **ALERT: " .. playerName .. " TELAH DISCONNECT!** 🚨"

    elseif status == "reconnected" then
        -- Always include mention for reconnect notifications
        payload.content = "<@" .. userIdStr .. "> 🟡 **" .. playerName .. " TELAH RECONNECT!** ✅"
    else
        -- Unknown status or "connected" (which is now disabled)
        warn('[Connection Status] Unknown or disabled status: ' .. tostring(status))
        return
    end

    -- Always add allowed_mentions if content has mentions
    if payload.content and payload.content ~= "" then
        -- Check if content contains user mention
        if string.find(payload.content, "<@" .. userIdStr .. ">") then
            -- CRITICAL: Make sure allowed_mentions format is correct
            payload.allowed_mentions = {
                parse = {},  -- Don't parse @everyone, @here, or @role
                users = {userIdStr},  -- Allow mention for this specific user ID
                roles = {}  -- No role mentions
            }

        else
            -- No allowed_mentions if no user mention in content
            payload.allowed_mentions = {
                parse = {},
                users = {},
                roles = {}
            }
        end

    end

    local body = HttpService:JSONEncode(payload)

    -- DEBUG: Print full payload before sending

    -- Additional validation debug
    if payload.allowed_mentions then
    end

    -- Send webhook with retry logic
    task.spawn(function()
        local attempt = 1
        local maxAttempts = 3
        local success = false

        while attempt <= maxAttempts and not success do
            local retryDelay = 2 * attempt -- Progressive delay

            if attempt > 1 then
                task.wait(retryDelay)
            end

            success, err = pcall(function()
                local httpMethod = nil
                local response = nil

                if syn and syn.request then
                    httpMethod = "syn.request"
                    response = syn.request({
                        Url = CONNECTION_WEBHOOK_URL,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = body
                    })
                elseif http_request then
                    httpMethod = "http_request"
                    response = http_request({
                        Url = CONNECTION_WEBHOOK_URL,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = body
                    })
                elseif fluxus and fluxus.request then
                    httpMethod = "fluxus.request"
                    response = fluxus.request({
                        Url = CONNECTION_WEBHOOK_URL,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = body
                    })
                elseif request then
                    httpMethod = "request"
                    response = request({
                        Url = CONNECTION_WEBHOOK_URL,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = body
                    })
                else
                    error("Executor does not support HTTP requests")
                end


                if response then
                end

                return response
            end)

            if success then
                break
            else
                warn('[Connection Status] ' .. status .. ' attempt ' .. attempt .. ' failed: ' .. tostring(err))
                attempt = attempt + 1
            end
        end

        if not success then
            warn('[Connection Status] All ' .. status .. ' attempts failed')
        end
    end)
end

-- Load previous session data (if available)
local function loadSessionData()
    local success, sessionId, disconnectTime = pcall(function()
        if readfile and isfile then
            local sessionFile = CONFIG_FOLDER .. "/last_session_" .. LocalPlayer.UserId .. ".json"

            if isfile(sessionFile) then
                local content = readfile(sessionFile)

                local data = HttpService:JSONDecode(content)

                return data.sessionId, data.disconnectTime
            else
            end
        else
        end
        return nil, nil
    end)

    if success then
        return sessionId, disconnectTime
    else
        print("[Reconnect] Error loading session data: " .. tostring(sessionId))
        return nil, nil
    end
end

-- Save session data
local function saveSessionData(sessionId, disconnectTime)
    if not writefile then
        return
    end

    if not ensureConfigFolder() then
        print("[Reconnect] Failed to create config folder")
        return
    end

    local sessionFile = CONFIG_FOLDER .. "/last_session_" .. LocalPlayer.UserId .. ".json"
    local sessionData = {
        sessionId = sessionId,
        disconnectTime = disconnectTime,
        playerName = LocalPlayer.Name,
        userId = LocalPlayer.UserId
    }


    local success, err = pcall(function()
        local encoded = HttpService:JSONEncode(sessionData)
        writefile(sessionFile, encoded)
    end)

    if success then
    else
        print("[Reconnect] Failed to save session data: " .. tostring(err))
    end
end

-- Initialize reconnect detection
local function initializeReconnectDetection()
    -- Verify that the webhook function is available
    if not sendConnectionStatusWebhook or type(sendConnectionStatusWebhook) ~= "function" then
        warn("[Reconnect] ERROR: sendConnectionStatusWebhook function not available!")
        warn("[Reconnect] Aborting reconnect detection initialization")
        return
    end

    local currentSessionId = game.JobId
    local currentTime = os.time()


    -- Load previous session data
    lastSessionId, lastDisconnectTime = loadSessionData()

    if lastSessionId and lastDisconnectTime then
        local timeDiff = currentTime - lastDisconnectTime

        -- NEW LOGIC: If offline > 1 minute, treat as reconnect (not new connection)
        if timeDiff > NEW_SESSION_THRESHOLD then
            local success, err = pcall(function()
                sendConnectionStatusWebhook("reconnected", "Reconnected after " .. math.floor(timeDiff/60) .. " minute(s) offline")
            end)
            if not success then
                print("[Reconnect] Error sending reconnect webhook: " .. tostring(err))
            end
        else
            -- Within 1 minute threshold - check reconnect type
            if currentSessionId == lastSessionId then
                -- Same server session
                local sessionPreview = string.sub(tostring(currentSessionId or "unknown"), 1, 8)
                local success, err = pcall(function()
                    sendConnectionStatusWebhook("reconnected", "Quick reconnect detected (Session: " .. sessionPreview .. "..., Time: " .. tostring(timeDiff) .. "s)")
                end)
                if not success then
                    print("[Reconnect] Error sending quick reconnect webhook: " .. tostring(err))
                end
            else
                -- Different server session within threshold
                local sessionPreview = string.sub(tostring(currentSessionId or "unknown"), 1, 8)
                local success, err = pcall(function()
                    sendConnectionStatusWebhook("reconnected", "Reconnected to different server (New Session: " .. sessionPreview .. "..., Time: " .. tostring(timeDiff) .. "s)")
                end)
                if not success then
                    print("[Reconnect] Error sending server change webhook: " .. tostring(err))
                end
            end
        end
    else
        -- No previous session data = fresh start (no webhook sent to avoid spam)
        -- Webhook "connected" disabled to reduce spam
        -- Only reconnect and disconnect will send notifications
    end

    -- Save current session as the new baseline
    lastSessionId = currentSessionId
    lastDisconnectTime = nil  -- Reset disconnect time since we're connected
end

-- Send connection status notification when script starts
task.spawn(function()
    -- Wait a bit to ensure all services are loaded
    task.wait(2)

    -- Debug: Check if function exists

    initializeReconnectDetection()

    -- NOTE: Online status updates are disabled to reduce webhook spam
    -- Only connect/disconnect/reconnect notifications will be sent
end)

local function sendDisconnectWebhook(username, reason)
    if hasSentDisconnectWebhook then
        return
    end

    hasSentDisconnectWebhook = true

    -- Stop online status timer and update to offline
    pcall(stopOnlineStatusTimer)

    -- Save session data before disconnect for reconnect detection
    pcall(function()
        saveSessionData(game.JobId, os.time())
    end)

    -- Send disconnect notification with user tag
    pcall(function()
        sendConnectionStatusWebhook("disconnected", reason or "Unknown disconnect reason")
    end)

end

local function setupDisconnectNotifier()
    local username = LocalPlayer.Name or "Unknown"
    local GuiService = game:GetService("GuiService")


    -- Monitor error messages for disconnect reasons
    GuiService.ErrorMessageChanged:Connect(function(message)
        if hasSentDisconnectWebhook then return end -- Prevent multiple sends

        print("[Disconnect Monitor] Error message detected: " .. tostring(message))
        local lowerMessage = string.lower(tostring(message))
        local reason = "Unknown"

        if lowerMessage:find("disconnect") or lowerMessage:find("connection lost") or lowerMessage:find("lost connection") then
            reason = "Connection Lost: " .. message
        elseif lowerMessage:find("kick") or lowerMessage:find("banned") or lowerMessage:find("removed") then
            reason = "Kicked/Banned: " .. message
        elseif lowerMessage:find("timeout") or lowerMessage:find("timed out") then
            reason = "Connection Timeout: " .. message
        elseif lowerMessage:find("server") and lowerMessage:find("full") then
            reason = "Server Full: " .. message
        elseif lowerMessage:find("shut") or lowerMessage:find("restart") then
            reason = "Server Shutdown/Restart: " .. message
        elseif lowerMessage:find("network") then
            reason = "Network Error: " .. message
        else
            -- For debugging, log all errors but don't send webhook
            print("[Disconnect Monitor] Non-disconnect error ignored: " .. message)
            return
        end

        task.spawn(function()
            sendDisconnectWebhook(username, reason)
        end)
    end)

    -- Monitor for player removal (enhanced)
    Players.PlayerRemoving:Connect(function(removedPlayer)
        if removedPlayer == LocalPlayer then
            if not hasSentDisconnectWebhook then
                task.spawn(function()
                    sendDisconnectWebhook(username, "Player Removed from Game (Clean Disconnect)")
                end)
            end
        end
    end)

    -- Monitor for game leaving
    game:GetService("GuiService").ErrorMessageChanged:Connect(function(message)
        if message and (message:find("Leaving") or message:find("Disconnecting")) then
            if not hasSentDisconnectWebhook then
                task.spawn(function()
                    sendDisconnectWebhook(username, "Game Leaving: " .. message)
                end)
            end
        end
    end)

    -- ====================================================================
    -- PING MONITOR REMOVED
    -- Reason: Reduce CPU/RAM usage (was checking every 10 seconds = 8,640/day)
    -- Replaced by: Other disconnect detection methods still active:
    --   - RunService.Stepped freeze detection
    --   - Heartbeat monitoring (below)
    --   - PlayerRemoving event
    --   - ScriptContext.Error event
    -- ====================================================================

    print("[Disconnect Monitor] Ping monitor disabled (using other detection methods)")

    -- Monitor for game freezes using Stepped delta
    RunService.Stepped:Connect(function(_, deltaTime)
        if deltaTime > FREEZE_THRESHOLD then
            task.spawn(function()
                sendDisconnectWebhook(username, "Game Freeze Detected (Delta: " .. string.format("%.2f", deltaTime) .. "s)")
            end)
        end
    end)

    -- Monitor for Roblox core errors
    local ScriptContext = game:GetService("ScriptContext")
    ScriptContext.Error:Connect(function(message, stack, script)
        if hasSentDisconnectWebhook then return end

        local lowerMessage = string.lower(tostring(message))
        if lowerMessage:find("disconnect") or lowerMessage:find("network") or
           lowerMessage:find("timeout") or lowerMessage:find("connection") then
            print("[Disconnect Monitor] Script error suggests disconnect: " .. tostring(message))
            task.spawn(function()
                sendDisconnectWebhook(username, "Script Error (Network/Connection): " .. tostring(message))
            end)
        end
    end)

    -- Heartbeat monitoring for complete game freeze
    local lastHeartbeat = tick()
    local heartbeatFailureCount = 0

    RunService.Heartbeat:Connect(function()
        lastHeartbeat = tick()
        heartbeatFailureCount = 0 -- Reset on successful heartbeat
    end)

    -- Check for heartbeat failures
    task.spawn(function()
        while true do
            task.wait(5) -- Check every 5 seconds
            local currentTime = tick()
            local timeSinceLastHeartbeat = currentTime - lastHeartbeat

            if timeSinceLastHeartbeat > 10 then -- If no heartbeat for 10 seconds
                heartbeatFailureCount = heartbeatFailureCount + 1
                print("[Disconnect Monitor] Heartbeat failure detected! Count: " .. heartbeatFailureCount .. ", Time since last: " .. string.format("%.2f", timeSinceLastHeartbeat) .. "s")

                if heartbeatFailureCount >= 2 and not hasSentDisconnectWebhook then
                    task.spawn(function()
                        sendDisconnectWebhook(username, "Heartbeat Failure - Game Unresponsive (" .. string.format("%.2f", timeSinceLastHeartbeat) .. "s)")
                    end)
                    break
                end
            end
        end
    end)

    -- Emergency disconnect detection via workspace monitoring
    local workspaceConnection
    workspaceConnection = workspace.ChildAdded:Connect(function()
        -- This connection will be severed on disconnect
        -- If we lose connection, this won't fire
    end)

    -- Monitor workspace connection loss
    task.spawn(function()
        task.wait(10) -- Wait for initialization
        local lastWorkspaceCheck = tick()

        while true do
            task.wait(15) -- Check every 15 seconds

            pcall(function()
                -- Try to access workspace - this will fail on disconnect
                local _ = workspace.Name
                lastWorkspaceCheck = tick()
            end)

            local currentTime = tick()
            if currentTime - lastWorkspaceCheck > 30 and not hasSentDisconnectWebhook then
                print("[Disconnect Monitor] Workspace access failure detected!")
                task.spawn(function()
                    sendDisconnectWebhook(username, "Workspace Access Failure - Likely Disconnected")
                end)
                break
            end
        end
    end)

end

-- Initialize Discord mention validation
local discordValid = pcall(validateDiscordMention)
if discordValid then
else
    warn("⚠️ [Auto Fish] Discord configuration validation failed")
end

-- Initialize disconnect notifier
local monitorSuccess = pcall(setupDisconnectNotifier)
if monitorSuccess then
else
    warn("⚠️ [Auto Fish] Disconnect monitor setup failed")
end

-- Auto-run test untuk memastikan sistem berfungsi (uncomment untuk testing)
-- task.spawn(function()
--     task.wait(5) -- Wait 5 seconds after startup
--     testDisconnectNotification()
-- end)

-- ====== ONLINE STATUS TIMER SYSTEM ======
-- Timer untuk update status online setiap 8 detik
-- ====================================================================
-- ONLINE STATUS SYSTEM REMOVED
-- Reason: Reduce webhook spam and memory usage
-- Replaced by: Connect/Disconnect/Reconnect notifications only
-- ====================================================================

-- Old online status functions have been removed to save memory:
-- - startOnlineStatusTimer() [REMOVED]
-- - stopOnlineStatusTimer() [REMOVED]
-- - updateOnlineStatus() loop [REMOVED]
-- - testOnlineStatusUpdate() [REMOVED]

-- ====== TEST FUNCTIONS & ERROR HANDLING ======
-- Online status test functions removed (no longer needed)
local function testOfflineStatusUpdate()
    -- Function kept for compatibility but does nothing
end

-- TEST FUNCTIONS untuk testing notification dengan tags
local function testDisconnectNotification()
    sendConnectionStatusWebhook("disconnected", "TEST: Manual disconnect test - Tag system check for User ID " .. tostring(DISCORD_USER_ID))
end

local function testReconnectNotification()
    sendConnectionStatusWebhook("reconnected", "TEST: Manual reconnect test - Tag system check for User ID " .. tostring(DISCORD_USER_ID))
end

-- Test function untuk validasi Discord mention format
local function validateDiscordMention()
    local userIdStr = tostring(DISCORD_USER_ID)
    local mentionFormat = "<@" .. userIdStr .. ">"


    -- Test allowed_mentions structure
    local testAllowedMentions = {
        parse = {},
        users = {userIdStr},
        roles = {}
    }

    return userIdStr
end

-- ERROR HANDLING untuk webhook failures
local function handleWebhookError(errorType, error)
    print("[Error Handler] " .. errorType .. " failed: " .. tostring(error))

    -- Online status updates are disabled, no retry needed
    -- Only reconnect/disconnect webhooks are active
end

-- Debug function untuk check message IDs
local function debugMessageStorage()
    for accountId, data in pairs(MESSAGE_ID_STORAGE) do
    end
end

-- ====== OPTIMIZATIONS SUMMARY ======
-- Optimizations made to fix "Out of local registers" error:
-- 1. Converted local variables to global: MESSAGE_ID_STORAGE, upgradeState, etc.
-- 2. Compacted functions: editDiscordMessage, sendNewStatusMessage, updateOnlineStatus
-- 3. Added createInstance helper to reduce Instance.new() local variables
-- 4. Simplified conditionals and reduced temporary variables
-- 5. Converted function declarations from local to global where possible

-- ENABLE untuk test functions (uncomment untuk testing):
--[[ DISABLED - Remove test functions untuk production
task.spawn(function()
    task.wait(10)
    testOnlineStatusUpdate()
    task.wait(5)
    debugMessageStorage()
end)
--]]

-- Quick test untuk verify optimizations worked


-- ====== ENHANCED TOGGLE FUNCTIONS ====== 
local function setAutoFarm(state)
    isAutoFarmOn = state
    updateConfigField("autoFarm", state)
    
    if state then
        equipRod() -- Auto equip rod when starting
    else
        cancelFishing()
        unequipRod() -- Auto unequip when stopping
    end
end

local function setSell(state)
    isAutoSellOn = state
    updateConfigField("autoSell", state)
end



local function setAutoCatch(state)
    isAutoCatchOn = state
    updateConfigField("autoCatch", state)
end

local function setAutoWeather(state)
    isAutoWeatherOn = state
    updateConfigField("autoWeather", state)
end

local function setAutoFishDelayForKohana()
    if autoFishMainSlider then
        autoFishMainSlider:Set(5)
    else
        setAutoFishMainDelay(5)
    end
end

local function setDelaysForPreset(presetKey)
    if presetKey == "auto1" or presetKey == "auto2" then
        -- Auto 1 dan Auto 2: Auto Fish Delay 0.1s, Auto Catch Delay 0.1s
        if autoFishMainSlider then
            autoFishMainSlider:Set(0.1)
        else
            setAutoFishMainDelay(0.1)
        end
        if autoCatchSlider then
            autoCatchSlider:Set(0.1)
        else
            setAutoCatchDelay(0.1)
        end
    elseif presetKey == "auto3" then
        -- Auto 3: Auto Fish Delay 5s, Auto Catch Delay 0.6s
        if autoFishMainSlider then
            autoFishMainSlider:Set(5)
        else
            setAutoFishMainDelay(5)
        end
        if autoCatchSlider then
            autoCatchSlider:Set(0.6)
        else
            setAutoCatchDelay(0.6)
        end
    end
end


-- ====================================================================
--                    AUTO-START (NO UI MODE - MANUAL CONFIG)
-- ====================================================================
-- Configuration from main_noui.lua loader OR saved config.json

-- Starting NO-UI mode

-- First, load config (will load from JSON if exists, otherwise use defaults)
loadConfig()

-- Check if config file exists
local configExists = false
if isfile then
    local configFile = getConfigFileName()
    configExists = isfile(configFile)
end

-- Variables to use
local useAutoFarm, useAutoSell, useAutoCatch, useAutoWeather, useAutoMegalodon, useGPUSaver, useTeleportLoc
local useAutoUpgradeRod, useAutoUpgradeBait

if configExists then
    -- Config exists, use saved settings from JSON
    useAutoFarm = config.autoFarm
    useAutoSell = config.autoSell
    useAutoCatch = config.autoCatch
    useAutoWeather = config.autoWeather
    useAutoMegalodon = config.autoMegalodon
    useGPUSaver = config.gpuSaver
    useTeleportLoc = config.teleportLocation or "Sisyphus Statue"
    useAutoUpgradeRod = config.autoUpgradeRod or false
    useAutoUpgradeBait = config.autoUpgradeBait or false

    -- Apply delays from config (using applyDelayConfig)
    applyDelayConfig()
else
    -- No config file, use settings from main_noui.lua and save them
    useAutoFarm = AUTO_FARM or false
    useAutoSell = AUTO_SELL or false
    useAutoCatch = AUTO_CATCH or false
    useAutoWeather = AUTO_WEATHER or false
    useAutoMegalodon = AUTO_MEGALODON or false
    useGPUSaver = GPU_SAVER or false
    useTeleportLoc = TELEPORT_LOCATION or "Sisyphus Statue"
    useAutoUpgradeRod = AUTO_UPGRADE_ROD or false
    useAutoUpgradeBait = AUTO_UPGRADE_BAIT or false

    -- Apply delays from main_noui.lua
    chargeFishingDelay = CHARGE_ROD_DELAY or 0.1
    autoFishMainDelay = AUTO_FISH_DELAY or 0.1
    autoSellDelay = AUTO_SELL_DELAY or 34
    autoCatchDelay = AUTO_CATCH_DELAY or 0.1
    weatherIdDelay = WEATHER_ID_DELAY or 10
    weatherCycleDelay = WEATHER_CYCLE_DELAY or 30

    -- Save to config for next time
    config.autoFarm = useAutoFarm
    config.autoSell = useAutoSell
    config.autoCatch = useAutoCatch
    config.autoWeather = useAutoWeather
    config.autoMegalodon = useAutoMegalodon
    config.gpuSaver = useGPUSaver
    config.teleportLocation = useTeleportLoc
    config.autoUpgradeRod = useAutoUpgradeRod
    config.autoUpgradeBait = useAutoUpgradeBait
    config.chargeFishingDelay = chargeFishingDelay
    config.autoFishDelay = autoFishMainDelay
    config.autoSellDelay = autoSellDelay
    config.autoCatchDelay = autoCatchDelay
    config.weatherIdDelay = weatherIdDelay
    config.weatherCycleDelay = weatherCycleDelay

    saveConfig()
end

-- Set global variable for totem functions
_G.useAutoFarm = useAutoFarm

local GPU_FPS_CAP = GPU_FPS_LIMIT or 8

-- Manual configuration function
local function startManualConfig()
    task.wait(3)  -- Wait for everything to load

    -- Teleport first
    teleportToNamedLocation(useTeleportLoc)
    task.wait(2)

    -- Enable GPU Saver if configured
    if useGPUSaver then
        enableGPUSaver()
        task.wait(0.5)
    end

    -- Enable Auto Farm if configured
    if useAutoFarm then
        setAutoFarm(true)
        task.wait(0.5)
    end

    -- Enable Auto Sell if configured
    if useAutoSell then
        setSell(true)
        task.wait(0.5)
    end

    -- Enable Auto Catch if configured
    if useAutoCatch then
        setAutoCatch(true)
        task.wait(0.5)
    end

    -- Enable Auto Weather if configured
    if useAutoWeather then
        setAutoWeather(true)
        task.wait(0.5)
    end

    -- Enable Auto Megalodon if configured
    if useAutoMegalodon then
        setAutoMegalodon(true)
        task.wait(0.5)
    end

    -- Auto Upgrade Rod/Bait already enabled in main startup sequence
    -- (Initial equip runs BEFORE this function is called)
end

-- ====================================================================
--                    AUTO LOOPS (CORE FISHING LOGIC)
-- ====================================================================

-- Enhanced Auto Farm Loop (Concurrent Flow)
task.spawn(function()
    while true do
        if isAutoFarmOn then
            local success, err = pcall(function()
                -- Concurrently equip and charge, then sequentially request minigame
                
                -- 1. Equip Tool (Concurrent)
                task.spawn(function()
                    if equipEvent then
                        equipEvent:FireServer(1)
                    end
                end)
                
                -- 2. Charge Rod (Concurrent)
                task.spawn(function()
                    if chargeEvent then
                        chargeEvent:InvokeServer(1755848498.4834)
                    end
                end)

                -- Wait for concurrent tasks to fire off
                task.wait(0.02) 

                -- 3. Request Minigame (Sequential)
                if requestMinigameEvent then
                    requestMinigameEvent:InvokeServer(1.2854545116425, 1)
                end

                -- Wait for server to process all requests
                task.wait(autoFishMainDelay)

                -- 4. Complete Fishing
                if fishingEvent then
                    fishingEvent:FireServer()
                end
            end)

            if not success then
                if not (string.find(tostring(err):lower(), "asset is not approved") or
                       string.find(tostring(err):lower(), "failed to load sound")) then
                    warn("[Auto Farm] Loop error: " .. tostring(err))
                end
            end
        end
        task.wait(0.1)
    end
end)

-- Auto Sell Loop
task.spawn(function()
    while true do
        if isAutoSellOn then
            pcall(function()
                if sellEvent then
                    sellEvent:InvokeServer()
                end
            end)
        end
        task.wait(autoSellDelay)
    end
end)

-- Auto Catch Loop
task.spawn(function()
    while true do
        if isAutoCatchOn then
            performAutoCatch()
        end
        task.wait(autoCatchDelay)
    end
end)

-- Auto Weather Loop
task.spawn(function()
    while true do
        if isAutoWeatherOn then
            for _, id in ipairs(WeatherIDs) do
                if not isAutoWeatherOn then break end
                pcall(function()
                    if WeatherEvent then
                        WeatherEvent:InvokeServer(id)
                    end
                end)
                local waited = 0
                while isAutoWeatherOn and waited < weatherIdDelay do
                    task.wait(0.1)
                    waited = waited + 0.1
                end
            end

            local waitedCycle = 0
            while isAutoWeatherOn and waitedCycle < weatherCycleDelay do
                task.wait(0.1)
                waitedCycle = waitedCycle + 0.1
            end
        end
        task.wait(0.1)
    end
end)

-- Auto Megalodon Hunt Loop
task.spawn(function()
    while true do
        if isAutoMegalodonOn then
            local success, err = pcall(function()
                autoDetectMegalodon()
            end)

            if not success then
                if not (string.find(tostring(err):lower(), "asset is not approved") or
                       string.find(tostring(err):lower(), "failed to load sound")) then
                    warn("[Megalodon] Loop error: " .. tostring(err))
                end
            end
        end
        task.wait(12)
    end
end)

-- Auto Upgrade Rod Loop
task.spawn(function()
    -- Initialize target on first run
    task.wait(5)
    currentRodTarget = findNextRodTarget()

    while true do
        if upgradeState.rod then
            -- Track auto farm state OUTSIDE pcall
            local wasAutoFarmEnabled = isAutoFarmOn

            local success, err = pcall(function()
                local currentCurrency = getCurrentCoins()
                local affordableRodId, rodPrice = getAffordableRod(currentCurrency)

                if not affordableRodId then
                    return -- Silent return
                end

                print("[Auto Upgrade Rod] Attempting to purchase rod " .. tostring(affordableRodId) .. " (price: " .. tostring(rodPrice) .. ", currency: " .. tostring(currentCurrency) .. ")")

                -- Stop auto farm before purchase
                if wasAutoFarmEnabled then
                    print("[Auto Upgrade Rod] Stopping auto farm for rod purchase...")
                    isAutoFarmOn = false
                    task.wait(1)
                end

                -- Attempt purchase up to 3 times
                local purchaseSuccess = false
                local guidOrErr = nil
                local lastError = "unknown error"

                for attempt = 1, 3 do
                    print("[Auto Upgrade Rod] Rod " .. tostring(affordableRodId) .. " purchase attempt " .. tostring(attempt) .. "/3")

                    local pcallSuccess, result, errorMsg = pcall(networkEvents.purchaseRodEvent.InvokeServer, networkEvents.purchaseRodEvent, affordableRodId)

                    if pcallSuccess and result then
                        purchaseSuccess = true
                        guidOrErr = errorMsg
                        print("[Auto Upgrade Rod] Rod " .. tostring(affordableRodId) .. " purchase successful on attempt " .. tostring(attempt))
                        break
                    elseif pcallSuccess then
                        lastError = tostring(errorMsg or "unknown error")
                        print("[Auto Upgrade Rod] Rod " .. tostring(affordableRodId) .. " purchase failed on attempt " .. tostring(attempt) .. ": " .. lastError)
                    else
                        lastError = "invoke failed: " .. tostring(result)
                        print("[Auto Upgrade Rod] Rod " .. tostring(affordableRodId) .. " invoke failed on attempt " .. tostring(attempt) .. ": " .. lastError)
                    end

                    if attempt < 3 then
                        task.wait(2)
                    end
                end

                if purchaseSuccess then
                    -- Wait 3 seconds for inventory to update
                    print("[Auto Upgrade Rod] Waiting 3 seconds for inventory update...")
                    task.wait(3)

                    -- Scan and equip best owned rod using new system
                    print("[Auto Upgrade Rod] Scanning inventory for best rod...")
                    detectAndEquipBestRod()

                    -- Clear failure records
                    failedRodAttempts[affordableRodId] = nil
                    rodFailedCounts[affordableRodId] = 0

                    -- Move to next target
                    currentRodTarget = findNextRodTarget()
                    if currentRodTarget then
                        print("[Auto Upgrade Rod] Successfully purchased rod " .. tostring(affordableRodId) .. ". Next target: ID " .. tostring(currentRodTarget))
                    else
                        print("[Auto Upgrade Rod] Successfully purchased rod " .. tostring(affordableRodId) .. ". All rods owned!")
                    end
                else
                    -- All 3 attempts failed - mark as owned
                    rodFailedCounts[affordableRodId] = 3

                    -- Move to next target
                    currentRodTarget = findNextRodTarget()
                    if currentRodTarget then
                        print("[Auto Upgrade Rod] Rod " .. tostring(affordableRodId) .. " failed 3 attempts - marked as owned. Next target: ID " .. tostring(currentRodTarget))
                    else
                        print("[Auto Upgrade Rod] Rod " .. tostring(affordableRodId) .. " failed 3 attempts - marked as owned. All rods completed!")
                    end
                end

            end)

            -- ALWAYS re-enable auto farm if it was enabled (even if error occurred)
            if wasAutoFarmEnabled and not isAutoFarmOn then
                isAutoFarmOn = true
                print("[Auto Upgrade Rod] Auto farm re-enabled after rod purchase process")
            end

            if not success then
                warn("[Auto Upgrade Rod] Loop error: " .. tostring(err))
            end
        end
        task.wait(15)
    end
end)

-- Auto Upgrade Bait Loop
task.spawn(function()
    -- Initialize target on first run
    task.wait(5)
    currentBaitTarget = findNextBaitTarget()

    while true do
        if upgradeState.bait then
            -- Track auto farm state OUTSIDE pcall
            local wasAutoFarmEnabled = isAutoFarmOn

            local success, err = pcall(function()
                local currentCurrency = getCurrentCoins()
                local affordableBaitId, baitPrice = getAffordableBait(currentCurrency)

                if not affordableBaitId then
                    return -- Silent return
                end

                print("[Auto Upgrade Bait] Attempting to purchase bait " .. tostring(affordableBaitId) .. " (price: " .. tostring(baitPrice) .. ", currency: " .. tostring(currentCurrency) .. ")")

                -- Stop auto farm before purchase
                if wasAutoFarmEnabled then
                    print("[Auto Upgrade Bait] Stopping auto farm for bait purchase...")
                    isAutoFarmOn = false
                    task.wait(1)
                end

                -- Attempt purchase up to 3 times
                local purchaseSuccess = false
                local guidOrErr = nil
                local lastError = "unknown error"

                for attempt = 1, 3 do
                    print("[Auto Upgrade Bait] Bait " .. tostring(affordableBaitId) .. " purchase attempt " .. tostring(attempt) .. "/3")

                    local pcallSuccess, result, errorMsg = pcall(networkEvents.purchaseBaitEvent.InvokeServer, networkEvents.purchaseBaitEvent, affordableBaitId)

                    if pcallSuccess and result then
                        purchaseSuccess = true
                        guidOrErr = errorMsg
                        print("[Auto Upgrade Bait] Bait " .. tostring(affordableBaitId) .. " purchase successful on attempt " .. tostring(attempt))
                        break
                    elseif pcallSuccess then
                        lastError = tostring(errorMsg or "unknown error")
                        print("[Auto Upgrade Bait] Bait " .. tostring(affordableBaitId) .. " purchase failed on attempt " .. tostring(attempt) .. ": " .. lastError)
                    else
                        lastError = "invoke failed: " .. tostring(result)
                        print("[Auto Upgrade Bait] Bait " .. tostring(affordableBaitId) .. " invoke failed on attempt " .. tostring(attempt) .. ": " .. lastError)
                    end

                    if attempt < 3 then
                        task.wait(2)
                    end
                end

                if purchaseSuccess then
                    -- Wait 3 seconds for inventory to update
                    print("[Auto Upgrade Bait] Waiting 3 seconds for inventory update...")
                    task.wait(3)

                    -- Scan and equip best owned bait using new system
                    print("[Auto Upgrade Bait] Scanning inventory for best bait...")
                    detectAndEquipBestBait()

                    -- Clear failure records
                    failedBaitAttempts[affordableBaitId] = nil
                    baitFailedCounts[affordableBaitId] = 0

                    -- Move to next target
                    currentBaitTarget = findNextBaitTarget()
                    if currentBaitTarget then
                        print("[Auto Upgrade Bait] Successfully purchased bait " .. tostring(affordableBaitId) .. ". Next target: ID " .. tostring(currentBaitTarget))
                    else
                        print("[Auto Upgrade Bait] Successfully purchased bait " .. tostring(affordableBaitId) .. ". All baits owned!")
                    end
                else
                    -- All 3 attempts failed - mark as owned
                    baitFailedCounts[affordableBaitId] = 3

                    -- Move to next target
                    currentBaitTarget = findNextBaitTarget()
                    if currentBaitTarget then
                        print("[Auto Upgrade Bait] Bait " .. tostring(affordableBaitId) .. " failed 3 attempts - marked as owned. Next target: ID " .. tostring(currentBaitTarget))
                    else
                        print("[Auto Upgrade Bait] Bait " .. tostring(affordableBaitId) .. " failed 3 attempts - marked as owned. All baits completed!")
                    end
                end

            end)

            -- ALWAYS re-enable auto farm if it was enabled (even if error occurred)
            if wasAutoFarmEnabled and not isAutoFarmOn then
                isAutoFarmOn = true
                print("[Auto Upgrade Bait] Auto farm re-enabled after bait purchase process")
            end

            if not success then
                warn("[Auto Upgrade Bait] Loop error: " .. tostring(err))
            end
        end
        task.wait(15)
    end
end)

-- ====================================================================
--     INITIAL EQUIP BEST ROD/BAIT (BEFORE AUTO LOOPS START)
-- ====================================================================

-- Initial equip MUST run BEFORE any auto loops start
print("[Startup] ================================================")
print("[Startup] Checking initial equipment...")

-- Initial equip best rod if auto upgrade enabled
if useAutoUpgradeRod then
    print("[Startup] Auto Upgrade Rod is enabled - equipping best rod...")
    task.wait(1)
    detectAndEquipBestRod()
    task.wait(1) -- Wait for equip to complete
end

-- Initial equip best bait if auto upgrade enabled
if useAutoUpgradeBait then
    print("[Startup] Auto Upgrade Bait is enabled - equipping best bait...")
    task.wait(1)
    detectAndEquipBestBait()
    task.wait(1) -- Wait for equip to complete
end

print("[Startup] Initial equipment check complete!")
print("[Startup] ================================================")

-- Enable auto upgrade states AFTER initial equip
if useAutoUpgradeRod then
    upgradeState.rod = true
    print("[Startup] Auto Upgrade Rod system enabled")

    -- Detect and apply rod delays on startup
    print("[Startup] Detecting equipped rod and applying delays...")
    task.wait(1)
    detectAndApplyRodDelays()
end

if useAutoUpgradeBait then
    upgradeState.bait = true
    print("[Startup] Auto Upgrade Bait system enabled")
end

-- Auto loops started AFTER initial equip complete

-- Run manual config auto-start
task.spawn(startManualConfig)

-- Initialization complete (no status reporter to save CPU/RAM)

-- ====================================================================
--                    SIMPLE GPU SAVER UI
-- ====================================================================

-- Create simple UI for GPU Saver toggle only
task.spawn(function()
    task.wait(5) -- Wait for everything to load

    local success = pcall(function()
        local CoreGui = game:GetService("CoreGui")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer

        -- Create ScreenGui
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "GPUSaverUI"
        screenGui.ResetOnSpawn = false
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        -- Main Frame (compact)
        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "MainFrame"
        mainFrame.Size = UDim2.new(0, 180, 0, 50)
        mainFrame.Position = UDim2.new(0, 10, 0.5, -25)
        mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        mainFrame.BorderSizePixel = 0
        mainFrame.Parent = screenGui

        -- Corner rounding
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = mainFrame

        -- GPU Saver Toggle Button
        local toggleButton = Instance.new("TextButton")
        toggleButton.Name = "GPUToggle"
        toggleButton.Size = UDim2.new(0, 160, 0, 35)
        toggleButton.Position = UDim2.new(0, 10, 0, 7.5)
        toggleButton.BackgroundColor3 = isGPUSaverOn and Color3.fromRGB(46, 125, 50) or Color3.fromRGB(183, 28, 28)
        toggleButton.Text = isGPUSaverOn and "🎨 GPU Saver: ON" or "🎨 GPU Saver: OFF"
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.TextSize = 14
        toggleButton.Font = Enum.Font.GothamBold
        toggleButton.Parent = mainFrame

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = toggleButton

        -- Toggle functionality
        toggleButton.MouseButton1Click:Connect(function()
            -- Toggle GPU Saver
            if isGPUSaverOn then
                disableGPUSaver()
                toggleButton.BackgroundColor3 = Color3.fromRGB(183, 28, 28)
                toggleButton.Text = "🎨 GPU Saver: OFF"
                config.gpuSaver = false
            else
                enableGPUSaver()
                toggleButton.BackgroundColor3 = Color3.fromRGB(46, 125, 50)
                toggleButton.Text = "🎨 GPU Saver: ON"
                config.gpuSaver = true
            end

            -- Save config
            pcall(saveConfig)
        end)

        -- Make draggable
        local dragging = false
        local dragInput, mousePos, framePos

        mainFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                mousePos = input.Position
                framePos = mainFrame.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        mainFrame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - mousePos
                mainFrame.Position = UDim2.new(
                    framePos.X.Scale,
                    framePos.X.Offset + delta.X,
                    framePos.Y.Scale,
                    framePos.Y.Offset + delta.Y
                )
            end
        end)

        -- Parent to CoreGui
        screenGui.Parent = CoreGui
    end)

    if not success then
        warn("[GPU Saver UI] Failed to create UI")
    end
end)
