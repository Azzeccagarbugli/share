_G.services = {
    ["3.5.8"] = Service:new("3.5.8", [[ 
    return function(ip)
        local log = dofile("Log.lua")

        local host, port = ip, 7777
        local socket = require("socket")
        local tcp = assert(socket.tcp())
        
        tcp:connect(host, port);
        tcp:send("\n");
        tcp:settimeout(2)
        while true do
            local s, status, partial = tcp:receive()
            --log.debug("[VALUE COMPUTED IN FUNCTION: ".. s .."]")
            if status == "closed" then break end
            log.info("[TEMPERATURE IS EQUAL TO ".. s .."]")
            return tonumber(s) or tonumber(partial)
        end
        tcp:close()
    end
    ]], function()
        local log = dofile("Log.lua")

        local temp = _G.services["3.5.8"].features[1]:call()
        log.info("[DISPLAY IS SHOWING: ".. temp .."]")

        local socket = require("socket")
        local server = assert(socket.bind("*", 7777))

        while true do
            server:settimeout(2)
            local client = server:accept()
            if client == nil then break end
            local line, err = client:receive()
            if not err then
                print("RICEVUTO")
                client:send(temp .. "\n")
                client:close()
                break
            end
        end
        server:close()
    end, function(n) return true end, Feature:new("2.1.*", function(n, m)
        return m > -10 and m < 45
    end))
    ,
    ["1.2.6.0"] = Service:new("1.2.6.0", [[ 
    return function(data, ip)
        local log = dofile("Log.lua")

        local host, port = ip, 7777
        local socket = require("socket")
        local tcp = assert(socket.tcp())
        
        tcp:connect(host, port);
        tcp:send(data.."\n");
        tcp:settimeout(2)
        while true do
            local s, status, partial = tcp:receive()
            log.debug("[VALUE COMPUTED IN FUNCTION: ".. s .."]")
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
    end, function(n) return n > 0 end, Feature:new("1.2.*", function(n, m)
        return n - m * m < 0.1
    end),Feature:new("3.5.*", function(n, m)
        return m > -10 and m < 45
    end)
    ),

    ["2.1.1.0"] = Service:new("2.1.1.0", [[ 
    return function(ip)
        local log = dofile("Log.lua")

        local host, port = ip, 7777
        local socket = require("socket")
        local tcp = assert(socket.tcp())
        
        tcp:connect(host, port);
        tcp:send("\n");
        tcp:settimeout(2)
        while true do
            local s, status, partial = tcp:receive()
            log.debug("[VALUE COMPUTED IN FUNCTION: ".. s .."]")
            if status == "closed" then break end
            return tonumber(s) or tonumber(partial)
        end
        tcp:close()
    end
    ]], function()
        local socket = require("socket")
        local server = assert(socket.bind("*", 7777))

        math.randomseed(os.time())

        local temp = math.random(0, 45)

        while true do
            server:settimeout(2)
            local client = server:accept()
            if client == nil then break end
            local line, err = client:receive()
            if not err then
                client:send(temp .. "\n")
                client:close()
                break
            end
        end
        server:close()
    end, function(n) return true end, 
     Feature:new("2.1.*", function(n, m)
        return m > -10 and m < 45
    end),
    Feature:new("3.5.*", function(n, m)
        return m > -10 and m < 45
    end)
    
  )
}
