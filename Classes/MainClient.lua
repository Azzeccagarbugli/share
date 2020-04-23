dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")

-- net.wf.setup(net.wf.mode.STA, "TIM-29055875", "Mercurio12345!")
-- net.wf.start()
-- net.service.mdns.start("whitecat-share")

--[[ function tprint(tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
        formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            tprint(v, indent + 1)
        else
            print(formatting .. v)
        end
    end
end ]]

services = {
    ["1.2.1.4.6.7.3.223"] = Service:new("1.2.1.4.6.7.3.223", -- function
    function(data, ip, port)
        udp_call:sendto(data, ip, port)
       --[[  local success, result = pcall(data)
        while not success do
            print("Error: " .. result)
            wait() -- or a specific time
            success, result = pcall(data)
        end
        print("Received: ", data, ip, port)
        table = load(data)
        udp:sendto(self.table_to_string(result), ip, port)

        socket.sleep(0.01) ]]
    end,
    
    -- daemon
    function(n) return math.sqrt(n) end, 
    
    -- pre
    function(n)
        if (n > 0) then
            return true
        else
            return false
        end
    end, -- features
    Feature:new("1.2.*", function(n, m) return n - m * m < 0.0001 end ))
}


disc_main = Share:new()
print(services["1.2.1.4.6.7.3.223"].features[1]:call(2))