-- LevelSystem.lua
-- Manages player levels (1-1000) and experience progression

local LevelSystem = {}
local playerLevels = {}
local playerExperience = {}
local levelRequirements = {}

-- Initialize level requirements (can be customized)
local function initializeLevelRequirements()
    for level = 1, 1000 do
        -- Exponential curve: Each level requires more experience
        levelRequirements[level] = math.floor(100 * (1.1 ^ (level - 1)))
    end
end

-- Initialize player level data
function LevelSystem:InitializePlayer(player)
    local userId = player.UserId
    playerLevels[userId] = 1
    playerExperience[userId] = 0
end

-- Add experience and handle level ups
function LevelSystem:AddExperience(player, amount)
    local userId = player.UserId
    if not playerLevels[userId] then
        self:InitializePlayer(player)
    end
    
    playerExperience[userId] = playerExperience[userId] + amount
    
    -- Check for level ups
    while playerLevels[userId] < 1000 and playerExperience[userId] >= levelRequirements[playerLevels[userId] + 1] do
        playerExperience[userId] = playerExperience[userId] - levelRequirements[playerLevels[userId] + 1]
        playerLevels[userId] = playerLevels[userId] + 1
    end
    
    return playerLevels[userId]
end

-- Get player's current level
function LevelSystem:GetLevel(player)
    local userId = player.UserId
    return playerLevels[userId] or 1
end

-- Get player's current experience
function LevelSystem:GetExperience(player)
    local userId = player.UserId
    return playerExperience[userId] or 0
end

-- Get experience required for next level
function LevelSystem:GetExperienceForNextLevel(player)
    local userId = player.UserId
    local currentLevel = playerLevels[userId] or 1
    if currentLevel >= 1000 then return 0 end
    return levelRequirements[currentLevel + 1] or 0
end

-- Set player's level
function LevelSystem:SetLevel(player, level)
    local userId = player.UserId
    playerLevels[userId] = math.clamp(level, 1, 1000)
    playerExperience[userId] = 0
end

-- Get progress to next level (0-1)
function LevelSystem:GetLevelProgress(player)
    local userId = player.UserId
    if not playerLevels[userId] then
        self:InitializePlayer(player)
    end
    
    local currentLevel = playerLevels[userId]
    if currentLevel >= 1000 then return 1 end
    
    local currentExp = playerExperience[userId] or 0
    local requiredExp = levelRequirements[currentLevel + 1] or 1
    
    return math.clamp(currentExp / requiredExp, 0, 1)
end

-- Initialize level requirements on module load
initializeLevelRequirements()

return LevelSystem
