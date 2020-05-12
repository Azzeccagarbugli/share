dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")
dofile("Utilities.lua")
dofile("Services.lua")

-- Square root
 --Utilities:call("2.1.1.0", _G.services, 2)

-- Temperature
_G.services["1.2.6.0"].features[2]:call()


--print(type(_G.services["3.5.8"]))
--_G.services["3.5.8"]:daemon()