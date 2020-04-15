Service = {}
Service.__index = Service

function Service:new(i, f, d, p, ...)
    if type(i) == "string" and type(f) == "function" and type(d) == "function" and
        type(p) == "function" then
        return setmetatable({
            name = i,
            func = f,
            daemon = d,
            pre = p,
            features = {...}
        }, Service)
    else
        return nil
    end
end

function Service:tabletostring(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len()-1)
    end
    return result.."}"
end
