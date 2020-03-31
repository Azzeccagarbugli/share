-- Caricamento del socket come dipendenza
local socket = require("socket")

-- Creazione del server TCP sulla porta 9898 del localhost
local server = assert(socket.bind("*", 9898))

-- Statistiche relative a hostname e porta utilizzata
local ip, port = server:getsockname()

-- print a message informing what's up
print("Socket in ascolto sulla porta " .. port)

-- Inizializzo il random
math.randomseed(os.time())

-- Funzione per la verifica delle precondizioni
function pre(value)
  if(value>15) then
    return false
  else 
    return true
  end
end
  
-- Loop per l'attesa dei client
while 1 do
  -- Attesa di un client 
  local client = server:accept()
  
  -- Calcolo della temperatura 
  temperatura = math.random(0,35)
  print("Temperatura prima del pre: "..temperatura)

  -- Timeout per evitare eventuali blocchi da parte del client 
  client:settimeout(10)
  
  -- Ricezione del messaggio
  local line, err = client:receive()

  -- Precondizioni verificate e nessun errore nel client 
  if (not err and pre(temperatura)) then
      client:send(line .."temperatura = "..temperatura) 
  end 

  -- Chiusura del client
  client:close()
end