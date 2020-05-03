Share = {}
Share.__index = Share

function Share:new() return setmetatable({services = {}}, Share) end

function Share:attach(s)
    if (getmetatable(s) == Service) and (not self:is_present(s, self.services)) then
        table.insert(self.services, s)
    end
end

function Share:detach(s)
    if (getmetatable(s) == Service) and self:is_present(s, self.services) then
        for i, k in pairs(self.services) do
            if (s == k) then table.remove(self.services, i) end
        end
    end
end

-- Cerca una entry "s" in una table "t"
function Share:is_present(s, t)
    for _, k in pairs(t) do if (s == k) then return true end end
    return false
end

function Share:discovery(macro_mib)
    local result = {}
    -- Memorizza gli indirizzi ip di tutti i dispositivi
    -- results = net.service.mdns.resolvehost("whitecat-share")
    -- ip = {"80.211.186.133"}
    local ip = {"10.0.15.228"}
    -- Vado a popolare set_services con tutti i servizi che trovo in rete
    for _, ip in pairs(ip) do self:open_udp_socket(ip, macro_mib, result) end
    return result
end

--[[
    Funzione interna che cerca nella tabella locale dei servizi
    coloro che hanno come prefisso <code> macro_mib <code> 
]]
function Share:find(macro_mib)
    if #self.services == 0 then return 0 end
    local saved = {}
    for _, k in pairs(self.services) do
        if (k.name:match(macro_mib)) then table.insert(saved, k.name) end
    end
    if #saved == 0 then
        return 0
    else
        return saved
    end
end

function Share:open_udp_socket(ip, macro_mib, result)
    local socket = require("socket")
    local udp_discovery = socket.udp()
    udp_discovery:setpeername(ip, 9898)
    udp_discovery:settimeout()
    udp_discovery:send(macro_mib)

    -- data è la stringa dalla forma {"1.2.4", "1.2.7", ...}
    local data_mib = udp_discovery:receive()

    if (data_mib and not (data_mib == "{}")) then
        pcall(load("mib_tab = " .. data_mib))
        local ip_tab = {}
        table.insert(ip_tab, ip)
        Utilities:add_new_ip(ip_tab, result, ip, mib_tab)
    end

    udp_discovery:close()
end
