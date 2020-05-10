dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")
dofile("Utilities.lua")

local log = dofile("Log.lua")

local services = {
    ["1.2.9.0"] = Service:new("1.2.9.0", -- function
    'function(data, ip, port) udp_call:sendto(self.daemon(), ip, port) end',
    -- daemon
                              function() return math.sqrt(data) end, -- pre
    function(n) return n > 0 end, -- features
    Feature:new("1.2.*", function(n, m) return n - m * m < 0.0001 end)),

    ["2.1.1.0"] = Service:new("2.1.1.0", -- function
    [[ 
    return function(data,ip)
        local host, port = ip, 7777
        local socket = require("socket")
        local tcp = assert(socket.tcp())
        
        tcp:connect(host, port);
        tcp:send(data.."\n");
        tcp:settimeout(2)
        while true do
            local s, status, partial = tcp:receive()
            print(s or partial)
            if status == "closed" then break end
            return s or partial
        end
        tcp:close()
    end
    ]], -- daemon 
    function()
        local socket = require("socket")
        local server = assert(socket.bind("*", 7777))
        local ip, port = server:getsockname()

        while true do
            server:settimeout(2)
            local client = server:accept()
            if client == nil then break end
            local line, err = client:receive()
            if not err then
                client:send(21 .."\n")
                client:close()
                break
            end
        end
        server:close()
    end, -- pre
    function(n) return n > 0 end, -- features
    Feature:new("2.1.*", function(n, m) return tonumber(m) > -10 and tonumber(m) < 45 end))
}

local disc_main = Share:new()

--square root
--services["1.2.9.0"].features[1]:call(2)

--temperature
services["2.1.1.0"].features[1]:call(1)
