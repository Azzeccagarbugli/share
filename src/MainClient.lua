dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")
dofile("Utilities.lua")
dofile("Services.lua")

--call alla temperatura
--_G.services["1.2.6.0"].features[4]:call()

--call radice quadrata (pre superate)
--_G.services["1.2.6.0"].features[2]:call(2)

--radice quadrata (pre non superate)
--_G.services["1.2.6.0"].features[2]:call(-1)

--display
--_G.services["3.5.8"]:daemon()

--call annidata
--_G.services["1.2.6.0"].features[1]:call();