Utilities = {}
Utilities.__index = Utilities

function Utilities:add_new_ip(keyTable, myTable, key, value)
    table.insert(keyTable, key)
    myTable[key] = value
end

function Utilities:print_table(tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
        local formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            self:print_table(v, indent + 1)
        else
            print(formatting .. v)
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
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result .. "[\"" .. k .. "\"]" .. "="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result .. self:table_to_string(v)
        elseif type(v) == "boolean" then
            result = result .. tostring(v)
        else
            result = result .. "\"" .. v .. "\""
        end
        result = result .. ","
    end
    -- Remove leading commas from the result
    if result ~= "" then result = result:sub(1, result:len() - 1) end
    return result .. "}"
end
