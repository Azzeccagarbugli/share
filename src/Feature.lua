--- Define an object Feature.
--- @class Feature
Feature = {}
Feature.__index = Feature

local log = dofile("Log.lua")

--- The constructor of the object Feature
--- @param i string The MIB of the current Feature
--- @param p function The post-condition necessary to checking
--- @return Feature The new Feature just created or nil in case of any issues 
function Feature:new(i, p)
    if type(i) == "string" and type(p) == "function" then
        return setmetatable({id = i, post = p}, Feature)
    else
        return nil
    end
end

function check_param(mib, param, udp_feature)
    if (param == nil) then
        udp_feature:send('mib = "' .. mib .. '"')
    else
        udp_feature:send('mib, param = "' .. mib .. '", ' .. param .. '')
    end
end

function check_result(param, current_ip, data_func)
    if (param == nil) then
        return load(data_func)()(current_ip)
    else
        return load(data_func)()(param, current_ip)
    end
end

--- A stub that searches, verifies, executes and produces the results related to a remote service
--- @vararg any The parameters that are called are a regular expression and the parameters on which to perform the operation
--- @return table, boolean Produces a boolean indicating whether the operation is successful and a table with the values ​​produced by the requested service 
function Feature:call(...)
    if self.id == "*" then return Share:mobile_app() end
    local set_services = Share:discovery(self.id)
    if Utilities:get_table_size(set_services) == 0 then
        log.fatal("[NO SERVICES MATCHED WITH THE SAME MIB]")
        return "nil"
    end

    log.trace("[" .. Utilities:get_table_size(set_services) .. " DEVICE FOUND]")
    Utilities:print_table(set_services)

    for current_ip, services in pairs(set_services) do
        for _, mib in pairs(services) do
            local socket = require("socket")
            local udp_feature = socket.udp()
            udp_feature:settimeout(4)
            udp_feature:setpeername(current_ip, 8888)
            check_param(mib, ..., udp_feature)
            local data_func = udp_feature:receive()

            if not (data_func == "nil") then
                log.info("[PRE-CONDITION SUCCESSFUL]")
                local res = check_result(..., current_ip, data_func)
                if (res and self.post(..., res)) then
                    log.info("[POST-CONDITION SUCCESSFUL]")
                    log.info("[MSG REDCEIVED: " .. res .. "] [FROM: " ..current_ip .. "]")
                    return res
                else
                    log.fatal("[POST-CONDITION NOT OVERCOME]")
                end
            else
                log.fatal("[PRE-CONDITION NOT SUCCESSFUL]")
            end
        end
    end
    log.fatal("[NO SERVICES FOUND]")
    return "nil"
end

