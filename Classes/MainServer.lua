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
    function(data)
        local socket = require("socket")
        udp_func = socket.udp()
        udp_func:setpeername(ip, 7777) --porta temporanea
        udp_func:settimeout(1)
        udp_func:send(data)
        udp_func:close()

        udp_daemon = socket.udp()
        udp_daemon:setsockname("*",7777)
        udp_daemon:settimeout(1)

        while true do
            result, ip_chiamato, port_chiamato = udp_daemon:receivefrom()
            print("Funtition: "..result, ip_chiamato, port_chiamato)
            if result then
                print("Ricevuto Risultato: ", result, ip_chiamato, port_chiamato)
                return result
            end
        end
     end,    

    -- daemon 
    function()
        udp_daemon = socket.udp()
        udp_daemon:setsockname("*", 9999)
        udp_daemon:settimeout(1)

        print("SONO NEL DAEMON")

        while true do
            local data, ip, port = udp_daemon:receivefrom()
            if data then
                print("RICEVUTO NEL DAEMON: "..data, ip, port)
                udp_daemon:sendto(tostring(math.sqrt(tonumber(data))), ip, port) 
            end
            socket.sleep(0.01)
        end
    end, 
    -- pre
    function(n) return n > 0 end,
    -- features
    Feature:new("1.2.*", function(n, m) return n - m * m < 0.1 end)
   ),

   ["1.2.1.1.1"] = Service:new("1.2.1.1.1", 
    -- function
    function(data) udp_call:sendto(services["1.2.1.1.1"].daemon(), ip_call, port_call) end,    
    -- daemon 
    function() return 1.4142135 end, 
    -- pre
    function(n) return n > 0 end,
    -- features
    Feature:new("1.2.*", function(n, m) return n - m * m < 0.1 end)
   )
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
            udp_call:sendto(string.dump(services[mib].func),ip_call,port_call) -- invio il dump di function
            services[mib].daemon()
        else 
            services[mib].func("nil") --non superate
        end 
    end  
    socket.sleep(0.01)
end