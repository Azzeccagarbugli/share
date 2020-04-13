Feature = {}
Feature.__index = Feature

function Feature:new(i, p)
    if type(i) == "string" and type(p) == "function" then
        return setmetatable({id = i, post = p}, Feature)
    else
        return nil
    end
end

function Feature:call(...)
    local set_services = Share:discovery(self.id)

    if #set_services == 0 then return false, nil end

    for index, service in pairs(set_services) do
        if service:pre(...) then
            service:daemon()
            if self.post(..., service:func(...)) then
                pcall(load(service:func(...)))
                break
            end
        end
    end
end


