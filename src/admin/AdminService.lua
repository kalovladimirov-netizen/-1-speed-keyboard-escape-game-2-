-- AdminService.lua
-- Admin tools and commands

local AdminService = {}
local GameConfig = require(script.Parent.Parent.config.GameConfig)

local ADMIN_ID = GameConfig.Admin.CreatorId

-- Check if player is admin
function AdminService:IsAdmin(player)
    return player.UserId == ADMIN_ID
end

-- Teleport player
function AdminService:TeleportPlayer(player, position)
    if player.Character then
        player.Character:MoveTo(position)
    end
end

-- Give player currency
function AdminService:GiveSpeed(player, amount, speedSystem)
    speedSystem:SetSpeed(player, amount)
    return true
end

function AdminService:GiveWins(player, amount, winsSystem)
    winsSystem:SetWins(player, amount)
    return true
end

function AdminService:GiveLumens(player, amount, lumensSystem)
    lumensSystem:SetLumens(player, amount)
    return true
end

-- Unlock world
function AdminService:UnlockWorld(player, worldId, worldSystem)
    worldSystem:UnlockWorld(player, worldId)
    return true
end

-- Activate weather
function AdminService:ActivateWeather(weatherId, weatherSystem)
    weatherSystem:ActivateWeather(weatherId)
    return true
end

-- Enable god mode
function AdminService:GodMode(player)
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Health = math.huge
        end
    end
end

-- Get admin commands
function AdminService:GetCommands()
    return {
        "/admin speed [amount]",
        "/admin wins [amount]",
        "/admin lumens [amount]",
        "/admin unlock [worldId]",
        "/admin weather [weatherId]",
        "/admin godmode",
        "/admin teleport [x,y,z]",
    }
end

return AdminService
