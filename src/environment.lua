local CoreMock = require("mocks/CoreMock")
local ConstructMock = require("mocks/ConstructMock")
local posixTime = require("posix.time") -- from luaposix

traceback = debug.traceback

local TestEnvironment = {}
TestEnvironment.__index = TestEnvironment

function TestEnvironment.New()
    local s = {}
    return setmetatable(s, TestEnvironment)
end

TestEnvironment.Prepare = function()
    -- There is a cross reference between DUSystem and Event if getTime isn't defined.

    getTime = function()
        local t = posixTime.clock_gettime(posixTime.CLOCK_MONOTONIC)
        return t.tv_sec + t.tv_nsec / 1000000000
    end
    Event = require("api-mockup/utils/event")

    require("api-mockup/system") -- Can't require("system") as that gives us a Lua-provided file.

    DUSystem.getUtcTime = getTime
    DUSystem.getArkTime = getTime
    DUSystem.getUtcOffset = function() return 0 end
    DUSystem.getLocale = function() return "en-US" end
    DUSystem.print = print
    _G.system = DUSystem

    require("api-mockup/controlunit")
    _G.unit = ControlUnit()

    _G.construct = ConstructMock.Instance()

    require("api-mockup/library")
    _G.library = DULibrary

    -- Setup DU-LuaC related features so we can use them in unit tests too.
    require("Events")
    require("AutoConfig")
    library.addEventHandlers(system)
    library.addEventHandlers(library)
    library.addEventHandlers(unit)

    -- Setup convencience function from DU-LuaC
    library.getCoreUnit = function()
        return CoreMock.Instance()
    end
end

return TestEnvironment
