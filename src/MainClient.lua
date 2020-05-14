dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")
dofile("Utilities.lua")
dofile("Services.lua")

_G.services["1.2.6.0"].features[1]:call(100)
_G.services["3.5.8"]:daemon()
