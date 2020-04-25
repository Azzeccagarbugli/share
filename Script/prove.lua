
--SERVER/CHIAMATO

local socket = require("socket")
udp = socket.udp()
udp:setsockname("*", 7777)
udp:settimeout(1)

while true do
    data = ""
    data, ip, port = udp:receivefrom()
    print(data)
    if data then
        print("RICEVUTOOOO")
        --[[ local success, result = pcall( abc )
            while not success do
            print("Error: "..result)
            wait() --or a specific time
            success, result = pcall( abc ) ]]
        --end
        --print("Received: ", data, ip, port)
        --table = load(data)
       --udp:sendto(table_to_string(result), ip, port)
    end

    socket.sleep(0.01)
end
