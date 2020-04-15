Share = {}
Share.__index = Share

function Share:new() return setmetatable({services = {}}, Share) end

function Share:attach(s)
    if (getmetatable(s) == Service) and (not self:ispresent(s))  then
        table.insert(self.services, s)
    end
end

function Share:detach(s)
    if (getmetatable(s) == Service) and self:ispresent(s) then
      for i,k in pairs(self.services) do if (s == k) then table.remove(self.services, i) end end 
    end 
end

function Share:ispresent(s) 
    for i,k in pairs(self.services) do if(s == k) then return true end end return false
end

function Share:discovery(macroMib)
     local set_services = {}
    -- Memorizza gli indirizzi ip di tutti i dispositivi
    results = net.service.mdns.resolvehost("whitecat-share")

    --Vado a popolare set_services con tutti i servizi che trovo in rete
    for k, v in pairs(results) do self.open_udp_socket(v,macroMib,set_services) end

    return set_services
end

--[[
    Funzione interna che cerca nella tabella locale dei servizi
    coloro che hanno come prefisso <code> macroMib <code> 
]]
function Share:find(macroMib)
    if #self.services == 0 then return 0 end
    local saved = {}
    for i,k in pairs(self.services) do
        if (k.name:match(macroMib)) then
          table.insert(saved, k.name)
        end
    end
    if #saved == 0 then return 0 else return saved end
end

function Share:open_udp_socket(ip,macroMib,set_services)
    local socket = require("socket")
    udp = socket.udp()
    udp:setpeername(ip, 9898)
    udp:settimeout()
    udp:send("Share:find("..macroMib..")")

    --data è la stringa dalla forma {"1.2.4", "1.2.7", ...}
    data = udp:receive()
    if data then
        pcall(load("tab = "..data.." for i,k in pairs(tab) do table.insert(set_services,tab[i]) end"))
    end
end