dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")
dofile("Utilities.lua")
dofile("Services.lua")

local log = dofile("Log.lua")

-- Square root
Utilities:call("2.1.1.0", _G.services, 1)

-- Temperature
-- _G.services["2.1.1.0"].features[1]:call()
