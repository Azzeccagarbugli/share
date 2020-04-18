dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")

-- net.wf.setup(net.wf.mode.STA, "TIM-29055875", "Mercurio12345!")
-- net.wf.start()
-- net.service.mdns.start("whitecat-share")


-- function DeepPrint (e)
--     if type(e) == "table" then
--        for k,v in pairs(e) do
--            if(type(v) == "table") then
--             DeepPrint(v)
--            else 
--            for x,y in pairs(v) do print("chiave: "..x ,y ) end
--            end
--        end  
--     else
--        print(e)
--     end
--  end

function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    else
      print(formatting .. v)
    end
  end
end

--socket sempre in ascolto
local socket = require("socket")
udp = socket.udp()
udp:setsockname("*", 9898)
udp:settimeout(1)

service1_main2 = Service:new("1.2.3", 
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

service2_main2 = Service:new("1.2.7.43", 
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


disc_main2 = Share:new()
result = disc_main2:discovery("1.2.*")

tprint(disc_main2:discovery("1.2.*"))