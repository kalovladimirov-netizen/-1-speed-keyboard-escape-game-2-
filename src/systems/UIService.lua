-- UIService.lua
-- Manages all UI display and updates

local UIService = {}

-- Create HUD
function UIService:CreateHUD(player, screenGui)
    -- Speed Display
    local speedLabel = Instance.new("TextLabel")
    speedLabel.Name = "SpeedLabel"
    speedLabel.Size = UDim2.new(0, 300, 0, 50)
    speedLabel.Position = UDim2.new(0, 10, 0, 10)
    speedLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    speedLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    speedLabel.TextSize = 24
    speedLabel.Font = Enum.Font.GothamBold
    speedLabel.Text = "Speed: 0"
    speedLabel.Parent = screenGui
    
    -- Level Display
    local levelLabel = Instance.new("TextLabel")
    levelLabel.Name = "LevelLabel"
    levelLabel.Size = UDim2.new(0, 300, 0, 50)
    levelLabel.Position = UDim2.new(0, 10, 0, 70)
    levelLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    levelLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    levelLabel.TextSize = 20
    levelLabel.Font = Enum.Font.Gotham
    levelLabel.Text = "Level: 1"
    levelLabel.Parent = screenGui
    
    -- Wins Display
    local winsLabel = Instance.new("TextLabel")
    winsLabel.Name = "WinsLabel"
    winsLabel.Size = UDim2.new(0, 200, 0, 40)
    winsLabel.Position = UDim2.new(1, -210, 0, 10)
    winsLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    winsLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    winsLabel.TextSize = 18
    winsLabel.Font = Enum.Font.GothamBold
    winsLabel.Text = "🏆 Wins: 1"
    winsLabel.Parent = screenGui
    
    -- Lumens Display
    local lumensLabel = Instance.new("TextLabel")
    lumensLabel.Name = "LumensLabel"
    lumensLabel.Size = UDim2.new(0, 200, 0, 40)
    lumensLabel.Position = UDim2.new(1, -210, 0, 60)
    lumensLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    lumensLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    lumensLabel.TextSize = 18
    lumensLabel.Font = Enum.Font.GothamBold
    lumensLabel.Text = "💡 Lumens: 100"
    lumensLabel.Parent = screenGui
    
    return {
        Speed = speedLabel,
        Level = levelLabel,
        Wins = winsLabel,
        Lumens = lumensLabel,
    }
end

-- Update HUD
function UIService:UpdateHUD(hudElements, speed, level, wins, lumens)
    if hudElements.Speed then
        hudElements.Speed.Text = "Speed: " .. tostring(math.floor(speed))
    end
    if hudElements.Level then
        hudElements.Level.Text = "Level: " .. tostring(level)
    end
    if hudElements.Wins then
        hudElements.Wins.Text = "🏆 Wins: " .. tostring(math.floor(wins))
    end
    if hudElements.Lumens then
        hudElements.Lumens.Text = "💡 Lumens: " .. tostring(math.floor(lumens))
    end
end

-- Show notification
function UIService:ShowNotification(player, message, duration)
    duration = duration or 3
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 400, 0, 60)
    notif.Position = UDim2.new(0.5, -200, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notif.TextColor3 = Color3.fromRGB(200, 200, 200)
    notif.TextSize = 16
    notif.Font = Enum.Font.Gotham
    notif.Text = message
    notif.Parent = screenGui
    
    task.wait(duration)
    screenGui:Destroy()
end

return UIService
