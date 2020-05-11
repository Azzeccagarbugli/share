Utilities = {}
Utilities.__index = Utilities

local log = dofile("Log.lua")

function Utilities:add_new_ip(keyTable, myTable, key, value)
    table.insert(keyTable, key)
    myTable[key] = value
end

function Utilities:print_table(tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
        local formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            log.ip(formatting)
            self:print_table(v, indent + 1)
        else
            log.srv(formatting .. v)
        end
    end
end

function Utilities:get_table_size(t)
    local count = 0
    for _, __ in pairs(t) do count = count + 1 end
    return count
end

function Utilities:table_to_string(tbl)
    if not (type(tbl) == "table") then return "{}" end
    local result = "{"
    for k, v in pairs(tbl) do
        if type(k) == "string" then
            result = result .. "[\"" .. k .. "\"]" .. "="
        end

        if type(v) == "table" then
            result = result .. self:table_to_string(v)
        elseif type(v) == "boolean" then
            result = result .. tostring(v)
        else
            result = result .. "\"" .. v .. "\""
        end
        result = result .. ","
    end

    if result ~= "" then result = result:sub(1, result:len() - 1) end
    return result .. "}"
end

function Utilities:search(mib, services)
    if self:get_table_size(services) == 0 then return false end

    for key, k in pairs(services) do if (key == mib) then return true end end

    log.fatal("[NO SERVICES MATCHED WITH THE SAME MIB]")
    return false
end

function Utilities:call(mib, table, param_feat, ...)
    if (self:search(mib, table)) then
        _G.services[mib].features[param_feat]:call(...)
    end
end
