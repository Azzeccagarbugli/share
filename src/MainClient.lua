dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")
dofile("Utilities.lua")
dofile("Services.lua")

-- local socket = require("socket")
-- local udp_mobile = socket.udp()
-- udp_mobile:setpeername("192.168.1.33", 9999)
-- udp_mobile:settimeout(5)
-- udp_mobile:send("mib,param = "..'"1.2.6.0",2')
-- local data_mib = udp_mobile:receive()
-- if (data_mib and not (data_mib == "{}")) then
--     print(data_mib)
-- end
-- udp_mobile:close() 

--[[ local socket = require("socket")

local udp2 = socket.udp()

while true do
    udp2:setpeername("193.204.11.50", 6868)
    udp2:settimeout(2)
    udp2:send("mib, param = " .. '"9.9.9", 2')
    local data2 = udp2:receive()
    if (not data2 == nil) then
        print("dato:" .. data2 .. ":fine")
    else
        print(data2)
    end
    udp2:close()
end ]]

-- call a Flutter
-- _G.services["1.2.6.0"].features[5]:call()

-- Call radice quadrata (pre superate)
--_G.services["1.2.6.0"].features[2]:call(2)

--Call caldaia
_G.services["5.3.1"].features[1]:call(20)

-- ottenere e stampare tutti i services nella sottorete
--[[ for i, k in pairs(_G.services["1.2.6.0"].features[4]:call()) do
    print("IP: " .. i)
    for _, v in pairs(k) do print("Servizi: " .. v) end
end ]]

-- Radice quadrata (pre non superate)
-- _G.services["1.2.6.0"].features[2]:call(-1)

-- Display
-- _G.services["3.5.8"]:daemon()

-- Call annidata
-- _G.services["1.2.6.0"].features[1]:call();
