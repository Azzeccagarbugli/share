dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")
dofile("Utilities.lua")
dofile("Services.lua")

local socket = require("socket")

local udp = socket.udp()
udp:setsockname("*", 9898)
udp:settimeout(1)

while true do
    print("ASCOLTO")
    local data_discovery, ip_discovery, port_discovery = udp:receivefrom()
    if data_discovery then
        print("RICEVUTO :"..data_discovery)
        break
    end
end