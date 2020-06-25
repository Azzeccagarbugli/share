dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")
dofile("Utilities.lua")
dofile("Services.lua")

local socket = require("socket")

local udp = socket.udp()
udp:setsockname("*", 2222)
udp:settimeout(1)

while true do
    print("ASCOLTO")
    local data_discovery, ip_discovery, port_discovery = udp:receivefrom()
    if data_discovery then
        print("RICEVUTO DA",ip_discovery,port_discovery)
        udp:sendto("CIAOOOO", ip_discovery,port_discovery)
        break
    end
end