dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")
dofile("Utilities.lua")
dofile("Services.lua")

local log = dofile("Log.lua")

local socket = require("socket")

local udp_discovery = socket.udp()
udp_discovery:setsockname("*", 9898)
udp_discovery:settimeout(1)

local udp_call = socket.udp()
udp_call:setsockname("*", 8888)
udp_call:settimeout(1)

local disc = Share:new()
disc:attach(_G.services["1.2.6.0"])
disc:attach(_G.services["2.1.1.0"])

while true do
    local data_discovery, ip_discovery, port_discovery =
        udp_discovery:receivefrom()
    if data_discovery then
        log.trace("[DISCOVERY]", "[SEARCHING FOR: " .. data_discovery .. "]",
                  "[IP: " .. ip_discovery .. "]",
                  "[PORT: " .. port_discovery .. "]")
        udp_discovery:sendto(
            Utilities:table_to_string(disc:find(data_discovery)), ip_discovery,
            port_discovery)
    end

    local data_call, ip_call, port_call = udp_call:receivefrom()
    if data_call then
        log.trace("[PRE]", "[DATA: " .. data_call .. "]",
                  "[IP: " .. ip_call .. "]", "[PORT: " .. port_call .. "]")
        load(data_call)()
        if (_G.services[mib].pre(param)) then
            udp_call:sendto(_G.services[mib].func, ip_call, port_call)
            _G.services[mib].daemon()
        else
            udp_call:sendto("nil", ip_call, port_call)
        end
    end

    socket.sleep(0.01)
end
