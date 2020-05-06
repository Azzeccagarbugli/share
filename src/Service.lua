--- Define an object Service.
--- @class Service.Service
Service = {}

Service.__index = Service

--- The constructor of the object Service
--- @param i string The MIB of the current Service
--- @param f string The function wrapped in a string that allows the communication with the inner protcol
--- @param d function The defined daemon that share data with the function of the same Service
--- @param p function The pre-condition necessary to checking 
--- @vararg any @arbitrary extra arguments
--- @return Service.Service The new Service just created or nil in case of any issues 
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
