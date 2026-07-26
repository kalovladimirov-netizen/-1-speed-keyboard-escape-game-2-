-- WeatherSystem.lua
-- Manages random and admin weather events with multipliers

local WeatherSystem = {}
local activeWeather = {}

local WeatherEvents = {
    -- Random Weather (10)
    {Id = 1, Name = "Sunny Boost", Type = "Random", SpeedMult = 2, WinsMult = 2, Duration = 300},
    {Id = 2, Name = "Storm Rush", Type = "Random", SpeedMult = 3, WinsMult = 1.5, Duration = 300},
    {Id = 3, Name = "Golden Hour", Type = "Random", SpeedMult = 2.5, WinsMult = 3, Duration = 300},
    {Id = 4, Name = "Lightning Strike", Type = "Random", SpeedMult = 4, WinsMult = 2, Duration = 300},
    {Id = 5, Name = "Blessed Day", Type = "Random", SpeedMult = 3, WinsMult = 4, Duration = 300},
    {Id = 6, Name = "Momentum Surge", Type = "Random", SpeedMult = 5, WinsMult = 2, Duration = 300},
    {Id = 7, Name = "Fortune Wind", Type = "Random", SpeedMult = 2, WinsMult = 5, Duration = 300},
    {Id = 8, Name = "Eclipse Power", Type = "Random", SpeedMult = 3, WinsMult = 3, Duration = 300},
    {Id = 9, Name = "Meteor Shower", Type = "Random", SpeedMult = 4, WinsMult = 3, Duration = 300},
    {Id = 10, Name = "Cosmic Alignment", Type = "Random", SpeedMult = 3, WinsMult = 4, Duration = 300},
    
    -- Admin Weather (7)
    {Id = 11, Name = "Admin Ultimate", Type = "Admin", SpeedMult = 10, WinsMult = 10, Duration = 600},
    {Id = 12, Name = "Admin Speed", Type = "Admin", SpeedMult = 20, WinsMult = 1, Duration = 600},
    {Id = 13, Name = "Admin Wealth", Type = "Admin", SpeedMult = 1, WinsMult = 20, Duration = 600},
    {Id = 14, Name = "Admin Double", Type = "Admin", SpeedMult = 2, WinsMult = 2, Duration = 600},
    {Id = 15, Name = "Admin Triple", Type = "Admin", SpeedMult = 3, WinsMult = 3, Duration = 600},
    {Id = 16, Name = "Admin Power", Type = "Admin", SpeedMult = 15, WinsMult = 15, Duration = 600},
    {Id = 17, Name = "Admin Chaos", Type = "Admin", SpeedMult = 50, WinsMult = 50, Duration = 300},
}

-- Get weather by ID
function WeatherSystem:GetWeather(weatherId)
    for _, weather in ipairs(WeatherEvents) do
        if weather.Id == weatherId then
            return weather
        end
    end
    return nil
end

-- Get random weather
function WeatherSystem:GetRandomWeather()
    local randomEvents = {}
    for _, weather in ipairs(WeatherEvents) do
        if weather.Type == "Random" then
            table.insert(randomEvents, weather)
        end
    end
    return randomEvents[math.random(1, #randomEvents)]
end

-- Activate weather
function WeatherSystem:ActivateWeather(weatherId)
    local weather = self:GetWeather(weatherId)
    if not weather then return false end
    
    activeWeather[weatherId] = {
        Weather = weather,
        StartTime = tick(),
    }
    
    -- Auto-deactivate after duration
    task.delay(weather.Duration, function()
        self:DeactivateWeather(weatherId)
    end)
    
    return true
end

-- Deactivate weather
function WeatherSystem:DeactivateWeather(weatherId)
    activeWeather[weatherId] = nil
end

-- Get active weather
function WeatherSystem:GetActiveWeather()
    return activeWeather
end

-- Get total active multipliers
function WeatherSystem:GetTotalMultipliers()
    local speedMult = 1
    local winsMult = 1
    
    for _, active in pairs(activeWeather) do
        speedMult = speedMult * active.Weather.SpeedMult
        winsMult = winsMult * active.Weather.WinsMult
    end
    
    return speedMult, winsMult
end

return WeatherSystem
