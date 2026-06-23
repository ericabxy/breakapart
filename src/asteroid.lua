local _ = require('src.const_libretro')
local sprite = require('src.sprite')

local FULLCIRCLE = 2 * math.pi
local XLARGESIZE = 51
local LARGESIZE = 39
local MEDIUMSIZE = 27
local SMALLSIZE = 16
local XLARGEOFFSET = 27
local LARGEOFFSET = 21
local MEDIUMOFFSET = 14
local SMALLOFFSET = 8
local XLARGESPEED = 20
local LARGESPEED = 50
local MEDIUMSPEED = 70
local SMALLSPEED = 120
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
  texture = meteor_01_xlarge,
  width = XLARGESIZE,
  height = XLARGESIZE,
  ox = -XLARGEOFFSET,
  oy = -XLARGEOFFSET,
  speed = XLARGESPEED,
  angle = false,
}

function asteroid:explode()
  if self.width == SMALLSIZE then return end
  local angle1 = love.math.random() * FULLCIRCLE
  local angle2 = (angle1 - math.pi) % FULLCIRCLE
  local asteroid1 = asteroid:new{ x = self.x, y = self.y, angle = angle1 }
  local asteroid2 = asteroid:new{ x = self.x, y = self.y, angle = angle2 }
  if self.width == XLARGESIZE then
    return asteroid1:get_large(), asteroid2:get_large()
  elseif self.width == LARGESIZE then
    return asteroid1:get_medium(), asteroid2:get_medium()
  elseif self.width == MEDIUMSIZE then
    return asteroid1:get_small(), asteroid2:get_small()
  end
end

function asteroid:get_large()
  self.texture = meteor_01_large
  self.width = LARGESIZE
  self.height = LARGESIZE
  self.ox = -LARGEOFFSET
  self.oy = -LARGEOFFSET
  self.speed = LARGESPEED
  return self
end

function asteroid:get_medium()
  self.texture = meteor_01_medium
  self.width = MEDIUMSIZE
  self.height = MEDIUMSIZE
  self.ox = -MEDIUMOFFSET
  self.oy = -MEDIUMOFFSET
  self.speed = MEDIUMSPEED
  return self
end

function asteroid:get_small()
  self.texture = meteor_01_small
  self.width = SMALLSIZE
  self.height = SMALLSIZE
  self.ox = -SMALLOFFSET
  self.oy = -SMALLOFFSET
  self.speed = SMALLSPEED
  return self
end

function asteroid:update(dt)
  self.x = self.x + math.cos(self.angle) * self.speed * dt
  self.y = self.y + math.sin(self.angle) * self.speed * dt
end

-- Constructor.
function asteroid:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  -- Initialization.
  if not o.angle then o.angle = love.math.random() * FULLCIRCLE end
  return o
end

return asteroid
