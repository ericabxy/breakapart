local gfx_bad_ships = require('src.gfx_bad_ships')
local sprite = require('src.sprite')

-- Class table.
local explosion = sprite:new{
  animation_frame = 1,
  animation_timer = 0,
  texture = gfx_bad_ships.texture1,
  quad = gfx_bad_ships.explosion1[1],
  width = 16,
  height = 16,
  ox = -8,
  oy = -8
}

function explosion:update(dt)
  self.animation_timer = self.animation_timer + dt
  if self.animation_timer >= .05 then
    self.animation_timer = 0
    self.animation_frame = self.animation_frame + 1
    if self.animation_frame <= #gfx_bad_ships.explosion1 then
      self.quad = gfx_bad_ships.explosion1[self.animation_frame]
    else
      self.animation_finished = true
    end
  end
end

-- Constructor.
function explosion:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  -- Initialization.
  return o
end

return explosion
