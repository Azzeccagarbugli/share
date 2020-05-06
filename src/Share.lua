--- Define an object Share.
--- @class Share.Share
Share = {}
Share.__index = Share

--- The constructor of the object Share
--- @return Share.Share The new Share just created with the table of available services  
function Share:new() return setmetatable({services = {}}, Share) end

--- This method inserts a service into the table of available services
--- @param s Service The service to add
function Share:attach(s)
    if (getmetatable(s) == Service) and (not self:is_present(s, self.services)) then
        table.insert(self.services, s)
    end
end

--- This method removes a service from the table of available services
--- @param s Service The service to remove
function Share:detach(s)
    if (getmetatable(s) == Service) and self:is_present(s, self.services) then
        for i, k in pairs(self.services) do
            if (s == k) then table.remove(self.services, i) end
        end
    end
end

--- This method search a service from the services table and returns true if it finds an occurrence
--- @param s Service The service to search
--- @param t table The table on which doing the search
--- @return boolean True if the service is present, false otherwise
function Share:is_present(s, t)
    for _, k in pairs(t) do if (s == k) then return true end end
    return false
end

function Share:discovery(macro_mib)
    local result = {}

    local ip = {"10.0.15.228"}

    for _, ip in pairs(ip) do self:open_udp_socket(ip, macro_mib, result) end
    return result
end

--- Internal function that retrieve the set of services with the corresponding prefix 
--- @param macro_mib string The prefix of the mib to search
--- @return table The set of corresponding services
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

--- Internal function used to establish a remote connection with udp socket
--- @param ip string The ip of the remote device 
--- @param macro_mib string MIB of the service owned by the remote service
--- @param result table The table used to save all results
function Share:open_udp_socket(ip, macro_mib, result)
    local socket = require("socket")
    local udp_discovery = socket.udp()
    udp_discovery:setpeername(ip, 9898)
    udp_discovery:settimeout()
    udp_discovery:send(macro_mib)

    local data_mib = udp_discovery:receive()

    if (data_mib and not (data_mib == "{}")) then
        pcall(load("mib_tab = " .. data_mib))
        local ip_tab = {}
        table.insert(ip_tab, ip)
        Utilities:add_new_ip(ip_tab, result, ip, mib_tab)
    end

    udp_discovery:close()
end
