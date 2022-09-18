--[[ Load DU classes into global namespace ]]
getTime = os.time
require("controlunit")
local unit = ControlUnit()
_G.unit = unit

require("api-mockup/system") -- Can't require("system") as that gives us a Lua-provided file.

DUSystem.getUtcTime = getTime
DUSystem.getArkTime = getTime
DUSystem.getUtcOffset = function () return 0 end
DUSystem.getLocale = function() return "en-US" end
_G.system = DUSystem

require("api-mockup/library")
_G.library = DULibrary

-- Setup DU-LuaC related features so we can use them in unit tests too.
require("Events")
require("AutoConfig")
library.addEventHandlers(system)
library.addEventHandlers(library)
library.addEventHandlers(unit)
