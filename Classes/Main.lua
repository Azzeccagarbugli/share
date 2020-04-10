dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")

sqrt_srv = Service:new("1.2.3", function()
    local socket = require("socket")
    udp = socket.udp()

    udp:setsockname("*", 9898)
    udp:settimeout(1)

    while true do
        data, ip, port = udp:receivefrom()
        data = tonumber(data)
        if (data) then
            print("Ricevuto da: ", data, ip, port)
            risultato = math.sqrt(data)
            udp:sendto(risultato, ip, port)
        end

        socket.sleep(0.01)
    end
end, function(n) return math.sqrt(n) end, function(n)
    if (n > 0) then
        return true
    else
        return false
    end
end, Feature:new("1.2.*", function(n, m)
    if (n - m * m < 0.1) then
        return true
    else
        return false
    end
end))

sqrt_srv.func()
