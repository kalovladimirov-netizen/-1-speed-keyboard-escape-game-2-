-- SpeedSystem.lua
-- Manages player speed, speed per step, and multipliers

local SpeedSystem = {}
local playerSpeeds = {}
local playerSpeedPerStep = {}
local playerSpeedMultipliers = {}

-- Initialize player speed data
function SpeedSystem:InitializePlayer(player)
    local userId = player.UserId
    playerSpeeds[userId] = 0
    playerSpeedPerStep[userId] = 1
    playerSpeedMultipliers[userId] = {}
end

-- Increment speed when player takes a step
function SpeedSystem:AddSpeed(player, amount)
    local userId = player.UserId
    if not playerSpeeds[userId] then
        self:InitializePlayer(player)
    end
    
    local multiplier = self:GetTotalMultiplier(player)
    local actualSpeed = amount * multiplier
    playerSpeeds[userId] = playerSpeeds[userId] + actualSpeed
    
    return playerSpeeds[userId]
end

-- Get player's current speed
function SpeedSystem:GetSpeed(player)
    local userId = player.UserId
    return playerSpeeds[userId] or 0
end

-- Set player's speed
function SpeedSystem:SetSpeed(player, amount)
    local userId = player.UserId
    playerSpeeds[userId] = math.max(0, amount)
    return playerSpeeds[userId]
end

-- Get speed per step
function SpeedSystem:GetSpeedPerStep(player)
    local userId = player.UserId
    return playerSpeedPerStep[userId] or 1
end

-- Set speed per step
function SpeedSystem:SetSpeedPerStep(player, amount)
    local userId = player.UserId
    playerSpeedPerStep[userId] = math.max(1, amount)
    return playerSpeedPerStep[userId]
end

-- Add speed multiplier
function SpeedSystem:AddMultiplier(player, name, value, duration)
    local userId = player.UserId
    if not playerSpeedMultipliers[userId] then
        playerSpeedMultipliers[userId] = {}
    end
    
    local multiplier = {
        Name = name,
        Value = value,
        Duration = duration,
        StartTime = tick(),
    }
    
    table.insert(playerSpeedMultipliers[userId], multiplier)
    
    if duration then
        task.delay(duration, function()
            self:RemoveMultiplier(player, name)
        end)
    end
end

-- Remove speed multiplier
function SpeedSystem:RemoveMultiplier(player, name)
    local userId = player.UserId
    if not playerSpeedMultipliers[userId] then return end
    
    for i, mult in ipairs(playerSpeedMultipliers[userId]) do
        if mult.Name == name then
            table.remove(playerSpeedMultipliers[userId], i)
            break
        end
    end
end

-- Get total multiplier (stacks multiplicatively)
function SpeedSystem:GetTotalMultiplier(player)
    local userId = player.UserId
    if not playerSpeedMultipliers[userId] then
        return 1
    end
    
    local total = 1
    for _, mult in ipairs(playerSpeedMultipliers[userId]) do
        total = total * mult.Value
    end
    
    return total
end

-- Get all active multipliers
function SpeedSystem:GetActiveMultipliers(player)
    local userId = player.UserId
    return playerSpeedMultipliers[userId] or {}
end

-- Reset speed (for rebirth)
function SpeedSystem:ResetSpeed(player)
    local userId = player.UserId
    playerSpeeds[userId] = 0
end

return SpeedSystem
