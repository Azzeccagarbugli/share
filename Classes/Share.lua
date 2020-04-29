Share = {}
Share.__index = Share

function Share:new() return setmetatable({services = {}}, Share) end

function Share:attach(s)
    if (getmetatable(s) == Service) and (not self:ispresent(s, self.services))  then
        table.insert(self.services, s)
    end
end

function Share:detach(s)
    if (getmetatable(s) == Service) and self:ispresent(s, self.services) then
      for i,k in pairs(self.services) do if (s == k) then table.remove(self.services, i) end end 
    end 
end

--Cerca una entry "s" in una table "t"
function Share:ispresent(s, t) 
    for i,k in pairs(t) do if(s == k) then return true end end return false
end


function Share:discovery(macroMib)
    local result = {}
    -- Memorizza gli indirizzi ip di tutti i dispositivi
    --results = net.service.mdns.resolvehost("whitecat-share")
    --ip = {"80.211.186.133"}
    ip = {"192.168.1.9"}
    --Vado a popolare set_services con tutti i servizi che trovo in rete
    for k, ip in pairs(ip) do self:open_udp_socket(ip,macroMib,result) end
    return result
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


function Share:open_udp_socket(ip,macroMib,result)
    local socket = require("socket")
    udp = socket.udp()
    udp:setpeername(ip, 9898)
    udp:settimeout()
    udp:send(macroMib)

    function addNewIP(keyTable, myTable, key, value)
        table.insert(keyTable, key)
        myTable[key] = value 
    end 

    --data è la stringa dalla forma {"1.2.4", "1.2.7", ...}
    data = udp:receive()
    if (data and not(data == "{}")) then  
        pcall(load("mib_tab = "..data))  
        ip_tab = {}
        table.insert(ip_tab,ip)
        addNewIP(ip_tab,result,ip,mib_tab)
    end
    udp:close()
end