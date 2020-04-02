Feature = {}
Feature.__index = Feature

function Feature:create(id)
    local fea = {}
    setmetatable(fea, Feature)
    fea.id = id
    return fea
end

function Feature:call(...)
    set_services = Share:discovery(self.id)

    if #set_services == 0 then return end

    for index, service in pairs(set_services) do
        if service:pre(...) then
            service:daemon()
            if self.post(..., service:func(...)) then
                pcall(load(service:func(...)))
            end
        end
    end
end

function Feature:post(...) end
