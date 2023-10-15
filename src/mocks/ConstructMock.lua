--[[
    Construct mock.
]]
---@class ConstructMock
---@field Instance fun():ConstructMock



local ConstructMock = {}
ConstructMock.__index = ConstructMock

local singelton

local aliothCenter = { -8.00, -8.00, -126303.00 }

local constructVars = {
    worldPosition = aliothCenter,
}

function ConstructMock.Instance()
    if singelton then
        return singelton
    end

    local s = {}

    function s.getTotalMass()
        return 1000
    end

    function s.getWorldPosition()
        return constructVars.worldPosition
    end

    ---@param coord Vec3
    function s.SetContructPostion(coord)
        constructVars.worldPosition = { coord:Unpack() }
    end

    function s.ResetContructPostion()
        constructVars.worldPosition = aliothCenter
    end

    singelton = setmetatable(s, ConstructMock)
    return singelton
end

return ConstructMock
