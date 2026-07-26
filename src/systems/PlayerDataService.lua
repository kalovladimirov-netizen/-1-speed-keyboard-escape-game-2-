-- PlayerDataService.lua
-- Handles player data persistence with DataStore

local PlayerDataService = {}
local DataStoreService = game:GetService("DataStoreService")
local playerStore = DataStoreService:GetDataStore("PlayerData")

-- Player data structure
local function CreatePlayerData()
    return {
        Speed = 0,
        Level = 1,
        Experience = 0,
        Rebirth = 0,
        RebirthMultiplier = 1,
        Wins = 1,
        Lumens = 100,
        Inventory = {
            Trails = {"Default"},
            Auras = {"Default"},
            Treadmills = {},
            Multipliers = {},
            SoundPacks = {},
        },
        EquippedItems = {
            Trail = "Default",
            Aura = "Default",
        },
        UnlockedWorlds = {1},
        UnlockedStages = {},
        Settings = {
            Volume = 1,
            Quality = "High",
            Notifications = true,
        },
        LastSave = tick(),
        PlayTime = 0,
    }
end

-- Load player data
function PlayerDataService:LoadPlayerData(player)
    local userId = player.UserId
    local success, data = pcall(function()
        return playerStore:GetAsync(userId)
    end)
    
    if success then
        if data then
            return data
        else
            return CreatePlayerData()
        end
    else
        warn("Failed to load data for player " .. userId)
        return CreatePlayerData()
    end
end

-- Save player data
function PlayerDataService:SavePlayerData(player, data)
    local userId = player.UserId
    data.LastSave = tick()
    
    local success, err = pcall(function()
        playerStore:SetAsync(userId, data)
    end)
    
    if not success then
        warn("Failed to save data for player " .. userId .. ": " .. err)
        return false
    end
    
    return true
end

-- Auto-save interval
local AUTO_SAVE_INTERVAL = 60

function PlayerDataService:StartAutoSave(player, getData)
    local connection
    connection = game:GetService("RunService").Heartbeat:Connect(function()
        if not player.Parent then
            connection:Disconnect()
            return
        end
        
        -- Save every 60 seconds
        if tick() % AUTO_SAVE_INTERVAL < 0.1 then
            local data = getData()
            self:SavePlayerData(player, data)
        end
    end)
end

return PlayerDataService
