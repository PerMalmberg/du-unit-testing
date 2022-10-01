--[[
    Core mock.
]]
---@class CoreMock
---@field Instance fun():CoreMock Returns the core instance
---@field getCurrentPlanetId fun():integer Returns the id of the closest body, or 0 when far enough in space
---@field getWorldGravity fun():number[] Returns the world gravity vector
---@field SetWorldGravity fun(gravity:Vec3) [For Unit testing]Returns the world gravity vector

local CoreMock = {}
CoreMock.__index = CoreMock

local singelton = nil

local CoreVars = {
    currentPlanetId = 2, -- Alioth
    constructWorldOrientationForward = { 0, 1, 0 },
    worldGravity = { 0, 0, 1 },
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

    function s.getWorldGravity()
        return CoreVars.worldGravity
    end

    function s.SetWorldGravity(gravity)
        CoreVars.worldGravity = { gravity:unpack() }
    end

    singelton = setmetatable(s, CoreMock)
    return singelton
end

return CoreMock
