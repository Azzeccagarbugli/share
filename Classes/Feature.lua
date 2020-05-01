Feature = {}
Feature.__index = Feature

function Feature:new(i, p)
    if type(i) == "string" and type(p) == "function" then
        return setmetatable({id = i, post = p}, Feature)
    else
        return nil
    end
end

function Feature:call(...)
    local set_services = Share:discovery(self.id)
    if Utilities:get_table_size(set_services) == 0 then return {}, false end -- ritorna table(?)

    Utilities:print_table(set_services)

    for current_ip, services in pairs(set_services) do
        for _, mib in pairs(services) do
            local socket = require("socket")
            local udp_feature = socket.udp()
            udp_feature:settimeout(2)
            udp_feature:setpeername(current_ip, 8888)
            udp_feature:send('mib, param = "' .. mib .. '", ' .. ... .. '')
            local data_func = udp_feature:receive() -- ricevo function dal chiamato

            if not (data_func == "nil") then -- check risultato precondizioni eseguite nel chiamato 
                print("PRE SUPERATE")
                local res = load(data_func)()(..., current_ip)
                if (res and self.post(..., res)) then
                    print("POST SUPERATE")
                    return res, true
                end
            end
        end
    end

    return {}, false
end

