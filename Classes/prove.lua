
--SERVER/CHIAMATO

local socket = require("socket")

function abc()
    table = {1,2,3} 
    return table
end

function table_to_string(tbl)
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

table = {1,2,3}

find = function(num)  return table end

udp = socket.udp()

udp:setsockname("192.168.1.9", 9898)
udp:settimeout(1)

while true do
    data, ip, port = udp:receivefrom()
    if data then
        print("Received: ", data, ip, port)
        table = load(data)
        udp:sendto(table_to_string(table), ip, port)
    end

    socket.sleep(0.01)
end
