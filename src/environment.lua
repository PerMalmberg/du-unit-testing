local posixTime = require("posix.time") -- from luaposix

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
    DUSystem.getUtcOffset = function () return 0 end
    DUSystem.getLocale = function() return "en-US" end
    _G.system = DUSystem

    require("controlunit")
    local unit = ControlUnit()
    _G.unit = unit

    require("api-mockup/library")
    _G.library = DULibrary

    -- Setup DU-LuaC related features so we can use them in unit tests too.
    require("Events")
    require("AutoConfig")
    library.addEventHandlers(system)
    library.addEventHandlers(library)
    library.addEventHandlers(unit)
end

return TestEnvironment