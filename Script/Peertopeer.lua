local socket = require("socket")
local udp = socket.udp()
local data

udp:settimeout(1)
udp:setsockname("*",7777)
udp:setpeername("*",7777)

while true do
  udp:send("2")
  data = udp:receive()
  if data then
    print("RICEVUTO"..data)
    break
  end
end


if data == nil then
  print("timeout")
else
  print(data)
end