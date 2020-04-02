Service = {}
Service.__index = Service

function Service:create(name)
    local srv = {}
    setmetatable(srv, Service)
    srv.name = name
    return srv
end

function Service:func(...)
    local socket = require("socket")

    --    self.balance = self.balance - amount
end

function Service:pre(...) if (...) then end end

-- create and use an Service
acc = Service:create(1000)
acc:withdraw(100)
