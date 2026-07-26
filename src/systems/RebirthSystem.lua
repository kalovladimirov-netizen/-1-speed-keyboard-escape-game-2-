-- RebirthSystem.lua
-- Manages player rebirths (max 21) and rebirth multipliers

local RebirthSystem = {}
local playerRebirths = {}
local playerRebirthMultipliers = {}

local MAX_REBIRTHS = 21

-- Initialize player rebirth data
function RebirthSystem:InitializePlayer(player)
    local userId = player.UserId
    playerRebirths[userId] = 0
    playerRebirthMultipliers[userId] = 1
end

-- Check if player can rebirth
function RebirthSystem:CanRebirth(player)
    local userId = player.UserId
    if not playerRebirths[userId] then
        self:InitializePlayer(player)
    end
    return playerRebirths[userId] < MAX_REBIRTHS
end

-- Perform rebirth
function RebirthSystem:Rebirth(player, speedSystem, levelSystem)
    local userId = player.UserId
    if not playerRebirths[userId] then
        self:InitializePlayer(player)
    end
    
    if not self:CanRebirth(player) then
        return false, "Maximum rebirths reached"
    end
    
    -- Increment rebirth count
    playerRebirths[userId] = playerRebirths[userId] + 1
    
    -- Calculate new multiplier (scales with rebirth count)
    playerRebirthMultipliers[userId] = 1 + (0.1 * playerRebirths[userId])
    
    -- Reset speed
    speedSystem:ResetSpeed(player)
    
    -- Keep everything else (level, wins, lumens, items, etc.)
    
    return true, "Rebirth successful! Multiplier: " .. tostring(playerRebirthMultipliers[userId])
end

-- Get player's rebirth count
function RebirthSystem:GetRebirthCount(player)
    local userId = player.UserId
    return playerRebirths[userId] or 0
end

-- Get player's rebirth multiplier
function RebirthSystem:GetRebirthMultiplier(player)
    local userId = player.UserId
    return playerRebirthMultipliers[userId] or 1
end

-- Set rebirth count (for loading)
function RebirthSystem:SetRebirthCount(player, count)
    local userId = player.UserId
    playerRebirths[userId] = math.clamp(count, 0, MAX_REBIRTHS)
    playerRebirthMultipliers[userId] = 1 + (0.1 * playerRebirths[userId])
end

-- Get rebirth progress (0-1)
function RebirthSystem:GetRebirthProgress(player)
    local userId = player.UserId
    local rebirths = playerRebirths[userId] or 0
    return rebirths / MAX_REBIRTHS
end

-- Get remaining rebirths
function RebirthSystem:GetRemainingRebirths(player)
    local userId = player.UserId
    local rebirths = playerRebirths[userId] or 0
    return MAX_REBIRTHS - rebirths
end

return RebirthSystem
