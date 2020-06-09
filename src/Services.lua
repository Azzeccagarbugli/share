_G.services = {
    ["3.5.8"] = Service:new("3.5.8", [[
        return function(data, ip)
            local host, port = ip, 7777
            local socket = require("socket")
            local tcp = assert(socket.tcp())
            
            tcp:connect(host, port);
            tcp:send(data.."\n");
            tcp:settimeout(2)
            while true do
                local s, status, partial = tcp:receive()
                if status == "closed" then break end
                return s or partial
            end
            tcp:close()
        end
    ]], function()
        local log = dofile("Log.lua")
        local socket = require("socket")

        while true do

            local temp = _G.services["3.5.8"].features[1]:call()
            if not (temp == "nil") then
                log.info("[TEMPERATURE IS EQUAL TO: " .. temp .. "]")
            end
            socket.sleep(2)
        end
    end, function(n) return false end, Feature:new("2.1.*", function(n, m)
        return m > -10 and m < 45
    end)),

    ["1.2.6.0"] = Service:new("1.2.6.0", [[ 
    return function(data, ip)
        local host, port = ip, 7777
        local socket = require("socket")
        local tcp = assert(socket.tcp())
        
        tcp:connect(host, port);
        tcp:send(data.."\n");
        tcp:settimeout(2)
        while true do
            local s, status, partial = tcp:receive()
            if status == "closed" then break end
            return s or partial
        end
        tcp:close()
    end
    ]], function()
        local socket = require("socket")
        local server = assert(socket.bind("*", 7777))

        while true do
            server:settimeout(2)
            local client = server:accept()
            if client == nil then break end
            local line, err = client:receive()
            if not err then
                client:send(tostring(math.sqrt(tonumber(line))) .. "\n")
                client:close()
                break
            end
        end
        server:close()
    end, function(n) return n > 0 end,
    Feature:new("4.1.*", function(n,m) return true end),
    Feature:new("1.2.*", function(n, m) return n - m * m < 0.1 end),
    Feature:new("3.5.*", function(n, m) return m > -10 and m < 45 end),
    Feature:new("*", function(n, m) return true end)
    ),

    ["2.1.1.0"] = Service:new("2.1.1.0", [[ 
    return function(ip)
        local host, port = ip, 7777
        local socket = require("socket")
        local tcp = assert(socket.tcp())
        
        tcp:connect(host, port);
        tcp:send("\n");
        tcp:settimeout(2)
        while true do
            local s, status, partial = tcp:receive()
            if status == "closed" then break end
            return tonumber(s) or tonumber(partial)
        end
        tcp:close()
    end
    ]], function()
        local socket = require("socket")
        local server = assert(socket.bind("*", 7777))

        -- lettura analogica del sensore temperatura
        -- channel = adc.attach(adc.ADC1, pio.GPIO34)
        -- raw, millivolts = channel:read()
        -- R0 = 100000
        -- R = 1023.0/(millivolts-1.0);
        -- R = R0*R;
        -- temp = (1.0/(math.log(R/R0)/4275+1/298.15)-273.15)-17.31
        math.randomseed(os.time())
        local temp = math.random(16, 17) + math.random()

        while true do
            server:settimeout(2)
            local client = server:accept()
            if client == nil then break end
            local line, err = client:receive()
            if not err then
                client:send(temp .. "\n")
                server:close()
                client:close()
                break
            end
        end
    end, function(n) return true end, Feature:new("2.1.*", function(n, m)
        return m > -10 and m < 45
    end), Feature:new("3.5.*", function(n, m) return m > -10 and m < 45 end)),

    ["4.1.7"] = Service:new("4.1.7", [[
    return function(ip)
        local host, port = ip, 7777
        local socket = require("socket")
        local tcp = assert(socket.tcp())
        tcp:connect(host, port);
        tcp:send("\n");
        tcp:settimeout(3)
        while true do
            local s, status, partial = tcp:receive()
            if status == "closed" then break end
            return s or partial
        end
        tcp:close()
    end
    ]], function()
        local socket = require("socket")
        local server = assert(socket.bind("*", 7777))

        while true do
            server:settimeout(4)
            local client = server:accept()
            if client == nil then break end
            local line, err = client:receive()
            if not err then
                client:send(_G.services["4.1.7"].features[1]:call() .. "\n")
                client:close()
                break
            end
        end
        server:close()
    end, function(n) return true end, Feature:new("2.1.*", function(n, m)
        return m > -10 and m < 45
    end))
}
