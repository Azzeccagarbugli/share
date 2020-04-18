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
    for k, v in pairs(tbl) do
        -- qui ho ip (==k)

        tprint(v, indent + 1)

    end
end

function Feature:call(...)
    local set_services = Share:discovery(self.id)
    if #set_services == 0 then return false, nil end

    for ip, services in pairs(set_services) do
        for i, mib in pairs(services) do
            local socket = require("socket")
            udp = socket.udp()
            udp:setpeername(ip, 8888)
            udp:settimeout()
            udp:send(services[mib]:pre(...))
            data = udp:receive()
            if (load(data)) then
                --[[ 
                service:daemon()
                if self.post(..., service:func(...)) then
                  pcall(load(service:func(...)))
                  break
                end ]]
            end
            udp:close()
        end
    end
end

