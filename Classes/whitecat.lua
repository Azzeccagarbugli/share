--CLIENT/CHIAMANTE

local socket = require("socket")
udp = socket.udp()

udp:setpeername("192.168.1.9", 9898)
udp:settimeout()

udp:send("return abc()")

data = udp:receive()

if data then
    print(data)
else
    print("NULL")
end
