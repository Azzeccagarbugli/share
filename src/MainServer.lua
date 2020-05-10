dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")
dofile("Utilities.lua")

-- Logger
local log = dofile("Log.lua")

-- socket sempre in ascolto
local socket = require("socket")

local udp_discovery = socket.udp()
udp_discovery:setsockname("*", 9898)
udp_discovery:settimeout(1)

local udp_call = socket.udp()
udp_call:setsockname("*", 8888)
udp_call:settimeout(1)

local services = {
    ["1.2.6.0"] = Service:new("1.2.6.0", -- function
    [[ 
    return function(data,ip)
        local log = dofile("Log.lua")

        local host, port = ip, 7777
        local socket = require("socket")
        local tcp = assert(socket.tcp())
        
        tcp:connect(host, port);
        tcp:send(data.."\n");
        tcp:settimeout(2)
        while true do
            local s, status, partial = tcp:receive()
            log.debug("[VALUE COMPUTED IN FUNCTION: ".. s .."]")
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
                client:send(tostring(math.sqrt(tonumber(line))) .. "\n")
                client:close()
                break
            end
        end
        server:close()
    end, -- pre
    function(n) return n > 0 end, -- features
    Feature:new("1.2.*", function(n, m) return n - m * m < 0.1 end)),

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
    Feature:new("2.1.*", function(n, m) return m > -10 and m < 45 end))
}

local disc = Share:new()
disc:attach(services["1.2.6.0"])
disc:attach(services["2.1.1.0"])

while true do
    local data_discovery, ip_discovery, port_discovery =
        udp_discovery:receivefrom()
    if data_discovery then
        log.trace("[DISCOVERY]", "[SEARCHING FOR: " .. data_discovery .. "]",
                  "[IP: " .. ip_discovery .. "]",
                  "[PORT: " .. port_discovery .. "]")
        udp_discovery:sendto(
            Utilities:table_to_string(disc:find(data_discovery)), ip_discovery,
            port_discovery) -- mib
    end

    local data_call, ip_call, port_call = udp_call:receivefrom()
    if data_call then
        log.trace("[PRE]", "[DATA: " .. data_call .. "]",
                  "[IP: " .. ip_call .. "]", "[PORT: " .. port_call .. "]")
        load(data_call)()
        if (services[mib].pre(param)) then -- eseguo le precondizioni
            udp_call:sendto(services[mib].func, ip_call, port_call)
            services[mib].daemon()
        else
            udp_call:sendto("nil", ip_call, port_call) -- non superate
        end
    end

    socket.sleep(0.01)
end
