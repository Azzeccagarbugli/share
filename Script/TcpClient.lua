--client
local host, port = "80.211.186.133", 7777
local socket = require("socket")
local tcp = assert(socket.tcp())

tcp:connect(host, port);
tcp:send("2\n");
while true do
    local s, status, partial = tcp:receive()
    print(s or partial)
    if status == "closed" then break end
end
tcp:close()