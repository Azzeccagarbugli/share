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

local socket = require("socket")

local udp1 = socket.udp()
local udp2 = socket.udp()
local udp3 = socket.udp()
local udp4 = socket.udp()

while true do
    print("INVIO")

    udp1:setpeername("10.0.2.2", 6868)
    udp1:settimeout(2)
    udp1:send("mib, param = " .. '"9.9.9", 2')
    local data1 = udp1:receive()
    if (not data1 == nil) then print("RICEVUTO"..data1) break end
    udp1:close()

    udp2:setpeername("192.168.1.64", 6868)
    udp2:settimeout(2)
    udp2:send("mib, param = " .. '"9.9.9", 2')
    local data2 = udp2:receive()
    if (not data2 == nil) then print("dato:"..data2..":fine") break end
    udp2:close()

    udp3:setpeername("10.0.2.16", 6868)
    udp3:settimeout(2)
    udp3:send("mib, param = " .. '"9.9.9", 2')
    local data3 = udp3:receive()
    if (not data3 == nil) then print("dato:"..data3..":fine") break end
    udp3:close()

    udp4:setpeername("127.0.0.1", 6868)
    udp4:settimeout(2)
    udp4:send("mib, param = " .. '"9.9.9", 2')
    local data4 = udp4:receive()
    if (not data4 == nil) then print("dato:"..data4..":fine") break end
    udp4:close()
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
