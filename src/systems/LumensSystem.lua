-- LumensSystem.lua
-- Manages player lumens (currency earned from business center)

local LumensSystem = {}
local playerLumens = {}
local playerLumensMultipliers = {}

-- Initialize player lumens data
function LumensSystem:InitializePlayer(player, startingLumens)
    local userId = player.UserId
    playerLumens[userId] = startingLumens or 100
    playerLumensMultipliers[userId] = {}
end

-- Add lumens
function LumensSystem:AddLumens(player, amount)
    local userId = player.UserId
    if not playerLumens[userId] then
        self:InitializePlayer(player, 100)
    end
    
    local multiplier = self:GetTotalLumensMultiplier(player)
    local actualLumens = amount * multiplier
    playerLumens[userId] = playerLumens[userId] + actualLumens
    
    return playerLumens[userId]
end

-- Get player's lumens
function LumensSystem:GetLumens(player)
    local userId = player.UserId
    return playerLumens[userId] or 100
end

-- Spend lumens (for purchases)
function LumensSystem:SpendLumens(player, amount)
    local userId = player.UserId
    if not playerLumens[userId] then
        return false, "Not enough lumens"
    end
    
    if playerLumens[userId] < amount then
        return false, "Not enough lumens"
    end
    
    playerLumens[userId] = playerLumens[userId] - amount
    return true, playerLumens[userId]
end

-- Set player's lumens
function LumensSystem:SetLumens(player, amount)
    local userId = player.UserId
    playerLumens[userId] = math.max(0, amount)
    return playerLumens[userId]
end

-- Add lumens multiplier
function LumensSystem:AddMultiplier(player, name, value, duration)
    local userId = player.UserId
    if not playerLumensMultipliers[userId] then
        playerLumensMultipliers[userId] = {}
    end
    
    local multiplier = {
        Name = name,
        Value = value,
        Duration = duration,
        StartTime = tick(),
    }
    
    table.insert(playerLumensMultipliers[userId], multiplier)
    
    if duration then
        task.delay(duration, function()
            self:RemoveMultiplier(player, name)
        end)
    end
end

-- Remove lumens multiplier
function LumensSystem:RemoveMultiplier(player, name)
    local userId = player.UserId
    if not playerLumensMultipliers[userId] then return end
    
    for i, mult in ipairs(playerLumensMultipliers[userId]) do
        if mult.Name == name then
            table.remove(playerLumensMultipliers[userId], i)
            break
        end
    end
end

-- Get total lumens multiplier
function LumensSystem:GetTotalLumensMultiplier(player)
    local userId = player.UserId
    if not playerLumensMultipliers[userId] then
        return 1
    end
    
    local total = 1
    for _, mult in ipairs(playerLumensMultipliers[userId]) do
        total = total * mult.Value
    end
    
    return total
end

-- Get all active multipliers
function LumensSystem:GetActiveMultipliers(player)
    local userId = player.UserId
    return playerLumensMultipliers[userId] or {}
end

return LumensSystem
