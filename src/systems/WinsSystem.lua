-- WinsSystem.lua
-- Manages player wins and wins-based progression

local WinsSystem = {}
local playerWins = {}
local playerWinsMultipliers = {}

-- Initialize player wins data
function WinsSystem:InitializePlayer(player, startingWins)
    local userId = player.UserId
    playerWins[userId] = startingWins or 1
    playerWinsMultipliers[userId] = {}
end

-- Add wins
function WinsSystem:AddWins(player, amount)
    local userId = player.UserId
    if not playerWins[userId] then
        self:InitializePlayer(player, 1)
    end
    
    local multiplier = self:GetTotalWinsMultiplier(player)
    local actualWins = amount * multiplier
    playerWins[userId] = playerWins[userId] + actualWins
    
    return playerWins[userId]
end

-- Get player's wins
function WinsSystem:GetWins(player)
    local userId = player.UserId
    return playerWins[userId] or 1
end

-- Spend wins (for purchases)
function WinsSystem:SpendWins(player, amount)
    local userId = player.UserId
    if not playerWins[userId] then
        return false, "Not enough wins"
    end
    
    if playerWins[userId] < amount then
        return false, "Not enough wins"
    end
    
    playerWins[userId] = playerWins[userId] - amount
    return true, playerWins[userId]
end

-- Set player's wins
function WinsSystem:SetWins(player, amount)
    local userId = player.UserId
    playerWins[userId] = math.max(0, amount)
    return playerWins[userId]
end

-- Add wins multiplier
function WinsSystem:AddMultiplier(player, name, value, duration)
    local userId = player.UserId
    if not playerWinsMultipliers[userId] then
        playerWinsMultipliers[userId] = {}
    end
    
    local multiplier = {
        Name = name,
        Value = value,
        Duration = duration,
        StartTime = tick(),
    }
    
    table.insert(playerWinsMultipliers[userId], multiplier)
    
    if duration then
        task.delay(duration, function()
            self:RemoveMultiplier(player, name)
        end)
    end
end

-- Remove wins multiplier
function WinsSystem:RemoveMultiplier(player, name)
    local userId = player.UserId
    if not playerWinsMultipliers[userId] then return end
    
    for i, mult in ipairs(playerWinsMultipliers[userId]) do
        if mult.Name == name then
            table.remove(playerWinsMultipliers[userId], i)
            break
        end
    end
end

-- Get total wins multiplier
function WinsSystem:GetTotalWinsMultiplier(player)
    local userId = player.UserId
    if not playerWinsMultipliers[userId] then
        return 1
    end
    
    local total = 1
    for _, mult in ipairs(playerWinsMultipliers[userId]) do
        total = total * mult.Value
    end
    
    return total
end

-- Get all active multipliers
function WinsSystem:GetActiveMultipliers(player)
    local userId = player.UserId
    return playerWinsMultipliers[userId] or {}
end

return WinsSystem
