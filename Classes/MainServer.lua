dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")

-- socket sempre in ascolto
local socket = require("socket")

udp = socket.udp()
udp:setsockname("*", 9898)
udp:settimeout(1)

udp_call = socket.udp()
udp_call:setsockname("*", 8888)
udp_call:settimeout(1)

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
    ["1.2.6.0"] = Service:new("1.2.6.0", 
    -- function
    [[ 
    return function(data,ip)
        local host, port = ip, 7777
        local socket = require("socket")
        local tcp = assert(socket.tcp())
        
        tcp:connect(host, port);
        tcp:send(data.."\n");
        tcp:settimeout(2)
        while true do
            local s, status, partial = tcp:receive()
            print(s or partial)
            if status == "closed" then break end
            return s or partial
        end
        tcp:close()
    end
    ]],    
    -- daemon 
    function()
        local socket = require("socket")
        local server = assert(socket.bind("*", 7777))
        local ip, port = server:getsockname()

        while true do
            server:settimeout(2)
            local client = server:accept()
            if client == nil then break end
              local line, err = client:receive()
              if not err then 
                client:send(tostring(math.sqrt(tonumber(line))).."\n") 
                client:close()
                break
              end
        end
        server:close()
    end, 
    -- pre
    function(n) return n > 0 end,
    -- features
    Feature:new("1.2.*", function(n, m) return n - m * m < 0.1 end)
   ),
}



disc = Share:new()
disc:attach(services["1.2.6.0"])
disc:attach(services["1.2.1.1.1"])

--disc:attach(Service:new(...))

ip_call, port_call = "", 0

while true do
    data, ip_discovery, port = udp:receivefrom()
    if data then
        print("Ricevuto [DISCOVERY]: ", data, ip_discovery, port)
        udp:sendto(table_to_string(disc:find(data)), ip_discovery, port) --mib
    end
    
    data1, ip_call, port_call = udp_call:receivefrom()
    if data1 then
        print("Ricevuto [PRE]: ", data1, ip_call, port_call)
        load(data1)()
        if(services[mib].pre(param)) then -- eseguo le precondizioni
            udp_call:sendto(services[mib].func,ip_call,port_call)
            services[mib].daemon()
        else 
            services[mib].func(nil) --non superate
        end 
    end  
    socket.sleep(0.01)
end