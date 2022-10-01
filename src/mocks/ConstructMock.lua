--[[
    Core mock.
]]
---@class ConstructMock
---@field Instance fun():ConstructMock Returns the core instance
---@field getCurrentPlanetId fun():integer Returns the id of the closest body, or 0 when far enough in space
---@field getWorldGravity fun():number[] Returns the world gravity vector
---@field SetWorldGravity fun(gravity:Vec3) [For Unit testing]Returns the world gravity vector

local ConstructMock = {}
ConstructMock.__index = ConstructMock

local singelton

local ConstructVars = {
    worldPosition = { -8.00, -8.00, -126303.00 }, -- Alioth center
}

function ConstructMock.Instance()
    if singelton then
        return singelton
    end

    local s = {}

    function s.getWorldPosition()
        return ConstructVars.worldPosition
    end

    singelton = setmetatable(s, ConstructMock)
    return singelton
end

return ConstructMock
