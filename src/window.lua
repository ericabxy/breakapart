local rectangle = require('src.rectangle')

-- Class table.
local window = rectangle:new{
  width = 320,
  height = 240,
}

function window:draw_objects_wrapped(t)
  for yoffset = -self.height, self.height, self.height do
    for xoffset = -self.width, self.width, self.width do
      for _, o in ipairs(t) do
        if type(o) == 'table' and type(o.draw) == 'function' then
          o:draw(xoffset, yoffset)
          o:paint(xoffset, yoffset)
        end
      end
    end
  end
end

-- Constructor.
function window:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return window
