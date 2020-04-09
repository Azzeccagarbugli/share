Share = {
    new = function()
        Share.__index = Share
        -- routine for start socket daemon 
        -- Questo è il main del servizio
        return setmetatable({services = {}}, Share)
    end,

    attach = function(s)
        if getmetatable(s) == "Service" and find(s) == 0 then
            table.insert(self.services, s)
        end
    end,

    detach = function(s) if find(s) ~= 0 then table.remove(s, find(s)) end end,

    discovery = function(s)
        local r = {}
        for k, v in pairs(self.services) do
            if string(v.name, s) == v.name then table.insert(r, s) end
        end
        return r
    end,

    find = function(s) -- local service function 
        if #self.services == 0 then return 0 end
        for k, v in pairs(self.services) do if v == s then return k end end
        return 0
    end
}

Service = {
    new = function(i, f, d, p, ...)
        Service.__index = Service
        if type(i) == "string" and type(f) == "function" and type(d) ==
            "function" and type(p) == "function" then
            return setmetatable({
                name = i,
                func = f,
                daemon = d,
                pre = p,
                features = {...}
            }, Service)
        else
            return nil
        end
    end
}

Feature = {
    new = function(i, p)
        Feature.__index = Feature
        if type(i) == "string" and type(p) == "function" then
            return setmetatable({id = i, post = p}, Feature)
        else
            return nil
        end
    end,

    call = function(...)
        -- tutto quello che c'è in sequence diagram
        return ok, r
    end
}

service_one = Service.new("1.2.3", -- name
function(a, b) -- function
    -- connect to daemon
    -- send(a)
    -- send(b)
    -- read(r)
    -- close connection
    return r
end, function() -- daemon
    -- connect to function
    -- read(a)
    ok, r1 = features[1].call(a)
    -- read(b)
    ok, r2 = features[2].call(b)
    -- send(a+b)
    -- close connection
end, function(a, b) -- precondition
    return a > 0 and b > 0
end, Feature.new( -- first feature
"1.2.*", function(a, b) return a > b end), Feature.new( -- second feature
"1.3.*", function(a, b) return a < b end))

share_service = Share.new()
share_service.attach(service_one)
