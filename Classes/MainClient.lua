dofile("Share.lua")
dofile("Service.lua")
dofile("Feature.lua")

-- net.wf.setup(net.wf.mode.STA, "TIM-29055875", "Mercurio12345!")
-- net.wf.start()
-- net.service.mdns.start("whitecat-share")

function tprint(tbl, indent)
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
end


disc_main = Share:new()

feat = Feature:new("1.2.*",function(n , ris) if(n-ris*ris < 0.000001) then return true else return false end end)
print(feat:call(2))
