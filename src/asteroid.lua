local _ = require('src.const_libretro')
local sprite = require('src.sprite')

local FULLCIRCLE = 2 * math.pi
local meteor_01_large = love.graphics.newImage('share/carlosalface_meteor-01-l.png')
local meteor_01_medium = love.graphics.newImage('share/carlosalface_meteor-01-m.png')
local meteor_01_small = love.graphics.newImage('share/carlosalface_meteor-01-s.png')
local meteor_01_xlarge = love.graphics.newImage('share/carlosalface_meteor-01-xl.png')
local meteor_02_large = love.graphics.newImage('share/carlosalface_meteor-02-l.png')
local meteor_02_medium = love.graphics.newImage('share/carlosalface_meteor-02-m.png')
local meteor_02_small = love.graphics.newImage('share/carlosalface_meteor-02-s.png')
local meteor_02_xlarge = love.graphics.newImage('share/carlosalface_meteor-02-xl.png')

-- Class table.
local asteroid = sprite:new{
  texture = meteor_01_large,
  width = 40,
  height = 40,
  ox = -20,
  oy = -20,
  angle = 0,
}

function asteroid:update(dt)
  local speed = 20
  self.x = self.x + math.cos(self.angle) * speed * dt
  self.y = self.y + math.sin(self.angle) * speed * dt
end

-- Constructor.
function asteroid:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  -- Initialization.
  o.angle = love.math.random() * FULLCIRCLE
  return o
end

return asteroid
