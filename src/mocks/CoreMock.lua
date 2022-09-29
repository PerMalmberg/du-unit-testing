--[[
    Core mock.
]]
---@class CoreMock
---@field Instance fun():CoreMock Returns the core instance
---@field getCurrentPlanetId fun():integer Returns the id of the closest body, or 0 when far enough in space
local CoreMock = {}
CoreMock.__index = CoreMock

local singelton = nil

local CoreVars = {
    worldPos = { -8.00, -8.00, -126303.00 }, -- Alioth center
    currentPlanetId = 2, -- Alioth
    constructWorldOrientationForward = { 0, 1, 0 }
}

function CoreMock.Instance()
    if singelton then
        return singelton
    end

    local s = {}

    function s.getWorldOrientationForward()
        return CoreVars.constructWorldOrientationForward
    end

    function s.getCurrentPlanetId()
        return CoreVars.currentPlanetId
    end

    function s.setCurrentPlanetId(id)
        CoreVars.currentPlanetId = id
    end

    singelton = setmetatable(s, CoreMock)
    return singelton
end

return CoreMock
