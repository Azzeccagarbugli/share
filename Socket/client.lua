local socket = require("socket")

function post(param, risultato)
    if (param - risultato * risultato < 0.1) then
        return true
    else
        return false
    end
end

udp = socket.udp()

udp:setpeername("192.168.1.8", 9898)
udp:settimeout()

udp:send("2")

data = tonumber(udp:receive())

if (data and post(2, data)) then
    pcall(load("risultato = " .. data))
else
    print("Postcondizioni non superate")
end
