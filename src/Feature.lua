--- Define an object Feature.
--- @class Feature.Feature
Feature = {}
Feature.__index = Feature

--- The constructor of the object Feature
--- @param i string The MIB of the current Feature
--- @param p function the post-condition necessary to checking
--- @return Feature.Feature The new Feature just created or nil in case of any issues 
function Feature:new(i, p)
    if type(i) == "string" and type(p) == "function" then
        return setmetatable({id = i, post = p}, Feature)
    else
        return nil
    end
end

--- A stub that searches, verifies, executes and produces the results related to a remote service
--- @vararg The parameters that are called are a regular expression and the parameters on which to perform the operation
--- @return Tuple,Boolean Produces a Boolean indicating whether the operation is successful and a tuple with the values ​​produced by the requested service. 
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

