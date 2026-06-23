local _ = require('src.const_libretro')
local sprite = require('src.sprite')

local FULLCIRCLE = 2 * math.pi
local SEGMENTS = 72
local SEGLENGTH = SEGMENTS / FULLCIRCLE
local quads = { }
local i = 54
for x = 0, 923, 13 do quads[i % SEGMENTS] = love.graphics.newQuad( x, 0, 13, 13, 936, 13 ) i = i + 1 end

-- Class table.
local missile = sprite:new{
  texture = love.graphics.newImage('share/titmouse001_sprites_missile.png'),
  quad = quads[0],
  time_left = 1,
  width = 13,
  height = 13,
  angle = 0,
  ox = -7,
  oy = -7
}

function missile:update(dt)
  self.time_left = self.time_left - dt
  local speed = 200
  self.x = self.x + math.cos(self.angle) * speed * dt
  self.y = self.y + math.sin(self.angle) * speed * dt
end

-- Constructor.
function missile:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  -- Initialization.
  o.angle = o.angle % FULLCIRCLE
  o.quad = quads[math.floor(o.angle * SEGLENGTH)]
  return o
end

return missile
