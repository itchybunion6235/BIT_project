local rmi = require "rmi"
local shortport = require "shortport"

portrule = shortport.port_or_service({1099}, {"java-rmi", "rmiregistry"})
function action(host,port, args)
  local registry = rmi.Registry:new( host, port )
  local status, j_array = registry:list()
  local data = j_array:getValues()
  for i, name in pairs(data) do
    if name == "jmxrmi" then
      data = "Vulnerable"
      return data
    else
      data = "Not Vulnerable"
    end
  end
  return data
end
