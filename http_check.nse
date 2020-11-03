-- The Head Section --
-- The Rule Section --
portrule = function(host, port)
    return port.protocol == "tcp"
            and port.number == 80
            and port.state == "open"
end

-- The Action Section --
action = function(host, port)
    return "Hello world!"
end
