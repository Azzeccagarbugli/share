dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")

-- net.wf.setup(net.wf.mode.STA, "TIM-29055875", "Mercurio12345!")
-- net.wf.start()
-- net.service.mdns.start("whitecat-share")

print_services = function (tab) for i,k in pairs(tab) do print(i,k.name) end end
print_matched_mib = function (tab) for i,k in pairs(tab) do print(i,k) end end

--socket sempre in ascolto
local socket = require("socket")
udp = socket.udp()
udp:setsockname("*", 9898)
udp:settimeout(1)

service1 = Service:new("1.2.3", 
    --function
    function(data,ip,port)
        local success, result = pcall(data)
        while not success do
            print("Error: "..result)
            wait() --or a specific time
            success, result = pcall(data)
        end
        print("Received: ", data, ip, port)
        table = load(data)
        udp:sendto(self.table_to_string(result), ip, port)

        socket.sleep(0.01)
    end, 
    --daemon
    function(n) return math.sqrt(n) end,
    --pre
    function(n)
        if (n > 0) then return true else return false end
    end,
    --features
    Feature:new("1.2.*", 
    function(n, m)
    if (n - m * m < 0.1) then return true else return false end 
    end
))

service2 = Service:new("1.2.7.43", 
    --function
    function(data,ip,port)
        local success, result = pcall(data)
        while not success do
            print("Error: "..result)
            wait() --or a specific time
            success, result = pcall(data)
        end
        print("Received: ", data, ip, port)
        table = load(data)
        udp:sendto(self.table_to_string(result), ip, port)

        socket.sleep(0.01)
    end, 
    --daemon
    function(n) return math.sqrt(n) end,
    --pre
    function(n)
        if (n > 0) then return true else return false end
    end,
    --features
    Feature:new("1.2.*", 
    function(n, m)
    if (n - m * m < 0.1) then return true else return false end 
    end
))


disc = Share:new()
disc:attach(service1)
disc:attach(service2)

while true do
    data, ip, port = udp:receivefrom()
    if data then
        local success, result = pcall(disc:find(data) )
            while not success do
            print("Error: "..result)
            wait() --or a specific time
            success, result = pcall( disc:find(data) )
        end
        print("Received: ", data, ip, port)
       udp:sendto(table_to_string(result), ip, port)
    end

    socket.sleep(0.01)
end

