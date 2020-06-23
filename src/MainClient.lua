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

while true do
    local socket = require("socket")
    local udp_mobile = socket.udp()
    udp_mobile:setpeername("10.0.2.2", 9999)
    udp_mobile:settimeout(5)
    udp_mobile:send("mib, param = " .. '"9.9.9", 2')
    local data_mib = udp_mobile:receive()
    if (data_mib and not (data_mib == "{}")) then print(data_mib) end
    udp_mobile:close()
end

-- ottenere e stampare tutti i services nella sottorete
--[[ for i, k in pairs(_G.services["1.2.6.0"].features[4]:call()) do
    print("IP: " .. i)
    for _, v in pairs(k) do print("Servizi: " .. v) end
end ]]

-- call alla temperatura
-- _G.services["1.2.6.0"].features[4]:call()

-- Call radice quadrata (pre superate)
-- _G.services["1.2.6.0"].features[2]:call(2)

-- Radice quadrata (pre non superate)
-- _G.services["1.2.6.0"].features[2]:call(-1)

-- Display
-- _G.services["3.5.8"]:daemon()

-- Call annidata
-- _G.services["1.2.6.0"].features[1]:call();
