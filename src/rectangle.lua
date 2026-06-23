local rectangle = {
  x = 0,
  y = 0,
  width = 8,
  height = 8
}

function rectangle:left() return self.x end
function rectangle:top() return self.y end
function rectangle:right() return self.x + self.width end
function rectangle:bottom() return self.y + self.height end

function rectangle:paint()
  --love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
  love.graphics.ellipse('line', self.x, self.y, self.width / 2, self.height / 2)
end

function rectangle:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return rectangle
