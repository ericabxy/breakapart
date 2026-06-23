local _ = require('src.const_libretro')
local gfx_bad_ships = require('src.gfx_bad_ships')
local missile = require('src.missile')
local sprite = require('src.sprite')

local FULLCIRCLE = 2 * math.pi
local SEGMENTS = 72
local SEGLENGTH = SEGMENTS / FULLCIRCLE
local TIMERLIMIT = 0.5

-- Class table.
local ship = sprite:new{
  controller_number = 0,
  texture = gfx_bad_ships.texture2,
  quad = gfx_bad_ships.ship1[1],
  quads = gfx_bad_ships.ship1,
  cooldown_timer = TIMERLIMIT,
  width = 15,
  height = 15,
  speed_x = 0,
  speed_y = 0,
  radius = 15,
  angle = 0,
  ox = -9,
  oy = -9,
}

function ship:accelerate(dt)
  local speed = 100
  self.speed_x = self.speed_x + math.cos(self.angle) * speed * dt
  self.speed_y = self.speed_y + math.sin(self.angle) * speed * dt
end

function ship:control(dt)
  if self.controller_number < 1 or self.controller_number > 8 then return end
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_UP) then
    self:accelerate(dt)
  end
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_LEFT) then
    self:rotate(-dt)
  elseif love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_RIGHT) then
    self:rotate(dt)
  end
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_X) then
    return self:fire()
  end
end

function ship:fire()
  if self.cooldown_timer >= TIMERLIMIT then
    self.cooldown_timer = 0
    return missile:new{
      angle = self.angle,
      x = self.x + math.cos(self.angle) * self.radius,
      y = self.y + math.sin(self.angle) * self.radius
    }
  end
end

function ship:rotate(dt)
  local turn_speed = 10
  self.angle = self.angle + turn_speed * dt
  self.angle = self.angle % FULLCIRCLE
  self.quad = self.quads[math.floor(self.angle * SEGLENGTH)]
end

function ship:update(dt)
  self.x = self.x + self.speed_x * dt
  self.y = self.y + self.speed_y * dt
  self.cooldown_timer = self.cooldown_timer + dt
end

-- Constructor.
function ship:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  -- Initialization.
  o.missiles = {}
  return o
end

return ship
