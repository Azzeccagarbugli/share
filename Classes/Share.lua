Share = {}
Share.__index = Share

function Share:new() return setmetatable({services = {}}, Share) end

function Share:attach(s)
    if getmetatable(s) == Service and self.find(s) == 0 then
        table.insert(self.services, s)
    end
end

function Share:detach(s)
    if self.find(s) ~= 0 then table.remove(s, self.find(s)) end
end


function Share:discovery(s)
    
    results = net.service.mdns.resolvehost("whitecat-share")
    for k, v in pairs(results) do v       end
end


--[[
    Funzione interna che cerca nella tabella locale dei servizi
     coloro che hanno come prefisso <code> macroMib <code> 
]]
function Share:find(macroMib)
    if #self.services == 0 then return nil end
    local saved = {}
    for i,k in pairs(self.services) do
        if k:match(macroMib) ==  nil then
        else table.insert( saved, k:match(reg) ) end
    end
    if #saved == 0 then return nil else return saved end
end

function Share:openUdpSocket(ip,macroMib)
    local socket = require("socket")
    udp = socket.udp()
    udp:setpeername(ip, 9898)
    udp:settimeout()
    udp:send("Share:find(macroMib)")
    load(udp:receive())
end

