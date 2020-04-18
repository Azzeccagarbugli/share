dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")

-- net.wf.setup(net.wf.mode.STA, "TIM-29055875", "Mercurio12345!")
-- net.wf.start()
-- net.service.mdns.start("whitecat-share")

-- socket sempre in ascolto
local socket = require("socket")
udp = socket.udp()
udp:setsockname("*", 9898)
udp:settimeout(1)

function table_to_string(tbl)
    if not (type(tbl) == "table") then return "{}" end
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result .. "[\"" .. k .. "\"]" .. "="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result .. table_to_string(v)
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

services = {
    ["1.2.1.4.6.7.3.223"] = Service:new("1.2.1.4.6.7.3.223", -- function
    function(data, ip, port)
        local success, result = pcall(data)
        while not success do
            print("Error: " .. result)
            wait() -- or a specific time
            success, result = pcall(data)
        end
        print("Received: ", data, ip, port)
        table = load(data)
        udp:sendto(self.table_to_string(result), ip, port)

        socket.sleep(0.01)
    end, -- daemon
    function(n) return math.sqrt(n) end, -- pre
    function(n)
        if (n > 0) then
            return true
        else
            return false
        end
    end, -- features
    Feature:new("1.2.*", function(n, m)
        if (n - m * m < 0.1) then
            return true
        else
            return false
        end
    end))
}

disc = Share:new()
disc:attach(services["1.2.1.4.6.7.3.223"])

while true do
    data, ip, port = udp:receivefrom()
    if data then
        print("Received: ", data, ip, port)
        udp:sendto(table_to_string(disc:find(data)), ip, port)
    end
    socket.sleep(0.01)
end
