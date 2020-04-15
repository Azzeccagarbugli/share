--CLIENT/CHIAMANTE

local socket = require("socket")
udp = socket.udp()

udp:setpeername("192.168.1.9", 9898)
udp:settimeout()

udp:send("abc()")

data = udp:receive()
set_services = {}

if data then
    if data then pcall(load(
        "tab = "..data..
        " for i,k in pairs(tab) do table.insert(set_services,tab[i]) end"
    ))
    end
    for i,k in pairs (set_services) do print(i,k) end
else
    print("NULL")
end
