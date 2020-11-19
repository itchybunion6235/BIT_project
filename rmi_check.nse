local rmi = require "rmi"
local shortport = require "shortport"

portrule = shortport.port_or_service({1098, 1099, 1090, 8901, 8902, 8903}, {"java-rmi", "rmiregistry"})
function action(host,port, args)
  local registry = rmi.Registry:new( host, port )
  local status, j_array = registry:list()
  local data = j_array:getValues()
  return data
end
