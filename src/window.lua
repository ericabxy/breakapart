local rectangle = require('src.rectangle')

-- Class table.
local window = rectangle:new{
  width = 320,
  height = 240,
}

-- Constructor.
function window:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return window
