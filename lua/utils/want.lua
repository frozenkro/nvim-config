return function(name)
  local out; if xpcall(
    function() out = require(name) end,
    function(e) out = e end)
  then return out
  else return nil, out end
end
