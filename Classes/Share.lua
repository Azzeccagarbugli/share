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
    local r = {}
    for k, v in pairs(self.services) do
        if string(v.name, s) == v.name then table.insert(r, s) end
    end
    return r
end

function Share:find(s)
    if #self.services == 0 then return 0 end
    for k, v in pairs(self.services) do if v == s then return k end end
    return 0
end
