Service = {}
Service.__index = Service

function Service:new(i, f, d, p, ...)
    if type(i) == "string" and type(f) == "string" and type(d) == "function" and
        type(p) == "function" then
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
