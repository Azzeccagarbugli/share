dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")
dofile("Utilities.lua")
dofile("Services.lua")

-- Square root
Utilities:call("1.2.6.0", _G.services, 1, 3)

-- Temperature
Utilities:call("2.1.1.0", _G.services, 1)
