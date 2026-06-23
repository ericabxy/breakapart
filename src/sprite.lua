local rectangle = require('src.rectangle')

-- Class table.
local sprite = rectangle:new{
  texture = nil,
  quad = nil,
  ox = 0,
  oy = 0,
}

function sprite:draw(ox, oy)
  ox, oy = ox or 0, oy or 0
  if self.quad then
    love.graphics.draw(
      self.texture,
      self.quad,
      math.floor(ox + self.ox + self.x),
      math.floor(oy + self.oy + self.y)
    )
  else
    love.graphics.draw(
      self.texture,
      math.floor(ox + self.ox + self.x),
      math.floor(oy + self.oy + self.y)
    )
  end
end

function sprite:wrap(rect)
  -- TODO: Take into account rect.x and rect.y.
  self.x = self.x % rect.width
  self.y = self.y % rect.height
end

-- Constructor.
function sprite:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return sprite
