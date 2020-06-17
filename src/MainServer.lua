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

local udp_mobileapp = socket.udp()
udp_mobileapp:setsockname("*", 7878)
udp_mobileapp:settimeout(1)

local udp_result = socket.udp()
udp_result:setsockname("*", 9999)
udp_result:settimeout(1)

local disc = Share:new()
disc:attach(_G.services["1.2.6.0"])
-- disc:detach(_G.services["1.2.6.0"])

disc:attach(_G.services["2.1.1.0"])
disc:attach(_G.services["3.5.8"])
-- disc:attach(_G.services["4.1.7"])

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

    local data_mobileapp, ip_mobileapp, port_mobileapp =
        udp_mobileapp:receivefrom()
    if data_mobileapp then
        log.trace("[MOBILE APP]", "[SEARCHING FOR MOBILE APP]",
                  "[IP: " .. ip_mobileapp .. "]",
                  "[PORT: " .. port_mobileapp .. "]")
        udp_mobileapp:sendto(Utilities:table_to_string(disc:find_all()),
                             ip_mobileapp, port_mobileapp)
    end

    local data_result, ip_result, port_result = udp_result:receivefrom()
    if data_result then
       log.trace("[SEND RESULT]", "[SENDING RESULT TO]","[IP: " .. ip_result .. "]","[PORT: " .. port_result .. "]")
       load(data_result)()
        if (_G.services[mib].pre(param)) then
            udp_result:sendto(_G.services[mib].result(param), ip_result, port_result)
            _G.services[mib].daemon()
        else
            udp_result:sendto("nil", ip_result, port_result)
        end
    end
end