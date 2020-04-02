local socket = require("socket")

function pre_sqrt(value)
    if (value > 0) then return true end
    return false
end

udp = socket.udp()

udp:setsockname("*", 9898)
udp:settimeout(1)

while true do
    data, ip, port = udp:receivefrom()
    data = tonumber(data)
    if (data and pre_sqrt(data)) then
        risultato = math.sqrt(data)
        print("Risultato calcolato: " .. risultato)
        print("Received: ", data, ip, port)
        udp:sendto(risultato, ip, port)
    end

    socket.sleep(0.01)
end
