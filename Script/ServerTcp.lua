--server
local socket = require("socket")
local server = assert(socket.bind("*", 7777))
local ip, port = server:getsockname()

while 1 do
  local client = server:accept()
  client:settimeout(10)
  local line, err = client:receive()
  if not err then client:send(line .. "\n") end
  client:close()
end