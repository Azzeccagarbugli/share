dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")

-- net.wf.setup(net.wf.mode.STA, "TIM-29055875", "Mercurio12345!")
-- net.wf.start()
-- net.service.mdns.start("whitecat-share")

--[[ function tprint(tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
        formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            tprint(v, indent + 1)
        else
            print(formatting .. v)
        end
    end
end ]]

services = {
    ["1.2.9.0"] = Service:new("1.2.9.0",
     -- function
    function(data, ip, port) udp_call:sendto(self.daemon(), ip, port) end,
    -- daemon
    function() return math.sqrt(data) end, 
    -- pre
    function(n) return n > 0 end,
     -- features
    Feature:new("1.2.*", function(n, m) return n - m * m < 0.0001 end ))
}


disc_main = Share:new()
print(services["1.2.9.0"].features[1]:call(2))