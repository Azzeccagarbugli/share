Feature = {}
Feature.__index = Feature

function Feature:new(i, p)
    if type(i) == "string" and type(p) == "function" then
        return setmetatable({id = i, post = p}, Feature)
    else
        return nil
    end
end


function tprint(tbl, indent)
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
end

function getTableSize(t)
    local count = 0
    for _, __ in pairs(t) do
        count = count + 1
    end
    return count
end

function Feature:call(...)
    local set_services = Share:discovery(self.id)
    if getTableSize(set_services) == 0 then return {},false end --ritorna table(?)
    
    tprint(set_services)
    
    for ip, services in pairs(set_services) do
        for i, mib in pairs(services) do
            local socket = require("socket")
            udp = socket.udp()
            udp:setpeername(ip, 8888)
            udp:settimeout()
            udp:send('mib, param = "'.. mib ..'", '.. ... ..'')
            data = udp:receive()
            if (not(data == "nil")) then --precondizioni
                if(self.post(...,data)) then --postcondizioni
                    return data,true
                end
            end
        udp:close()
        end
    end
end

