local http = require "http"
local shortport = require "shortport"
local string = require "string"
local stdnse = require "stdnse"

portrule = shortport.http

action = function(host, port) 
  local tome, resp, redirect_url, title, versions, result
  versions = {"8.0.2", "8.0.3", "8.0.4", "9.0.0-M1", "9.0.0-M2"}
  resp = http.get( host, port, stdnse.get_script_args(SCRIPT_NAME..".url") or "/" )

  if resp.body ~= nil then
    title = string.match(resp.body, "<[Tt][Ii][Tt][Ll][Ee][^>]*>([^<]*)</[Tt][Ii][Tt][Ll][Ee]>")
    tome = string.match (title, " %(%a+%)")
    if (tome ~= nil) then
      print(tome)
      tome = string.match(tome, "%a+")
    end
    title = string.match(title, " %([%d.]*%)$")
    if (tome ~= nil) then
      title = string.match(title, "[%d%.]+")
    end
  end
  result = "Vulnerable"
  if tome == "TomEE" then  
    for key, value in pairs(versions) do
      if title == value then
        result = "Not vulnerable"
        break
      end
    end
  else
    result = "Not Vulnerable"
  end    

  local output_str = result
  if redirect_url then
    output_str = output_str .. "\n" .. ("Requested resource was %s"):format( redirect_url )
  end
  return output_str
end

