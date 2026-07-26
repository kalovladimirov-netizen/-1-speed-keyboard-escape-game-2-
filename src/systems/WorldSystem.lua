-- WorldSystem.lua
-- Manages worlds, mini-worlds, and stage progression

local WorldSystem = {}
local playerWorlds = {}
local playerStages = {}

-- Initialize player world data
function WorldSystem:InitializePlayer(player)
    local userId = player.UserId
    playerWorlds[userId] = {
        UnlockedWorlds = {1},
        CurrentWorld = 1,
        CompletedWorlds = {},
    }
    playerStages[userId] = {
        CurrentStage = 1,
        CompletedStages = {},
        StageTimes = {},
    }
end

-- Unlock world
function WorldSystem:UnlockWorld(player, worldId)
    local userId = player.UserId
    if not playerWorlds[userId] then
        self:InitializePlayer(player)
    end
    
    if not self:IsWorldUnlocked(player, worldId) then
        table.insert(playerWorlds[userId].UnlockedWorlds, worldId)
    end
end

-- Check if world is unlocked
function WorldSystem:IsWorldUnlocked(player, worldId)
    local userId = player.UserId
    if not playerWorlds[userId] then
        self:InitializePlayer(player)
    end
    
    for _, id in ipairs(playerWorlds[userId].UnlockedWorlds) do
        if id == worldId then
            return true
        end
    end
    return false
end

-- Get unlocked worlds
function WorldSystem:GetUnlockedWorlds(player)
    local userId = player.UserId
    if not playerWorlds[userId] then
        self:InitializePlayer(player)
    end
    return playerWorlds[userId].UnlockedWorlds
end

-- Set current world
function WorldSystem:SetCurrentWorld(player, worldId)
    local userId = player.UserId
    if not playerWorlds[userId] then
        self:InitializePlayer(player)
    end
    
    if self:IsWorldUnlocked(player, worldId) then
        playerWorlds[userId].CurrentWorld = worldId
        return true
    end
    return false
end

-- Get current world
function WorldSystem:GetCurrentWorld(player)
    local userId = player.UserId
    if not playerWorlds[userId] then
        self:InitializePlayer(player)
    end
    return playerWorlds[userId].CurrentWorld
end

-- Complete stage
function WorldSystem:CompleteStage(player, stageId, time)
    local userId = player.UserId
    if not playerStages[userId] then
        self:InitializePlayer(player)
    end
    
    -- Mark as completed
    local already = false
    for _, id in ipairs(playerStages[userId].CompletedStages) do
        if id == stageId then
            already = true
            break
        end
    end
    
    if not already then
        table.insert(playerStages[userId].CompletedStages, stageId)
    end
    
    -- Record time
    if time then
        playerStages[userId].StageTimes[stageId] = time
    end
end

-- Get completed stages
function WorldSystem:GetCompletedStages(player)
    local userId = player.UserId
    if not playerStages[userId] then
        self:InitializePlayer(player)
    end
    return playerStages[userId].CompletedStages
end

-- Get stage completion percentage
function WorldSystem:GetCompletionPercentage(player)
    local userId = player.UserId
    if not playerStages[userId] then
        self:InitializePlayer(player)
    end
    
    local completed = #playerStages[userId].CompletedStages
    local total = 184
    return (completed / total) * 100
end

return WorldSystem
