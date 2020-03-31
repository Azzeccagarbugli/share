-- Caricamento del socket come dipendenza
local socket = require("socket")

-- Inizializzazione del TCP
local tcp = assert(socket.tcp())

-- Connesione al client al segunte host con alla porta 9898
tcp:connect("192.168.1.8", 9898)
tcp:send("\n")

-- Attesa della callback di risposta
while true do
    -- Ricezione del dato
    local s, status, partial = tcp:receive()

    -- Validazione del dato ricevuto come file LUA
    pcall(load(partial))

    -- Chiusura della ricezione
    if status == "closed" then
        break
    end
end

-- Chiusura del TCP
tcp:close()
