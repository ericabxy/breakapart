local _ = require('src.const_libretro')
local sfx_background_music = require('src.sfx_background_music')
local asteroid = require('src.asteroid')
local explosion = require('src.explosion')
local ship = require('src.ship')
local window = require('src.window')

local asteroids = {}
local bullets = {}
local controllers = {}
local explosions = {}
local ships = {}

function love.load()
  asteroids[1] = asteroid:new{ x = 50, y = 50 }
  asteroids[2] = asteroid:new{ x = window.width - 50, y = 50 }
  asteroids[3] = asteroid:new{ x = window.width / 2 , y = window.height - 50 }
end

function love.update(dt)
  for x = #asteroids, 1, -1 do
    local o = asteroids[x]
    o:update(dt)
    o:wrap(window)
    for y = #ships, 1, -1 do
      local o2 = ships[y]
      if o:is_touching(o2) then
        controllers[o2.controller_number] = nil
        table.insert(explosions, o2:explode( ))
        table.remove(ships, y)
        if #ships < 1 then sfx_background_music:off() end
      end
    end
  end
  for bullet_i = #bullets, 1, -1 do
    local this_bullet = bullets[bullet_i]
    this_bullet:update(dt)
    this_bullet:wrap(window)
    if this_bullet.time_left <= 0 then table.remove(bullets, bullet_i) end
    for asteroid_i = #asteroids, 1, -1 do
      local this_asteroid = asteroids[asteroid_i]
      if this_bullet:is_touching(this_asteroid) then
        table.remove(bullets, bullet_i)
        table.remove(asteroids, asteroid_i)
        break
      end
    end
  end
  for x = #explosions, 1, -1 do
    local o = explosions[x]
    o:update(dt)
    if o.animation_finished then table.remove(explosions, x) end
  end
  for _, o in ipairs(ships) do
    local bullet = o:control(dt)
    if bullet then table.insert(bullets, bullet) end
    o:update(dt)
    o:wrap(window)
  end
end

function love.draw()
  window:draw_objects_wrapped(asteroids)
  window:draw_objects_wrapped(bullets)
  window:draw_objects_wrapped(explosions)
  window:draw_objects_wrapped(ships)
end

function love.joystickpressed(n, b)
  n, b = n + 1, b + 1
  if b == RETRO_DEVICE_ID_JOYPAD_START and not controllers[n] then
    sfx_background_music:on()
    table.insert(ships, ship:new{ controller_number = n, x = window.width / 2, y = window.height / 2 })
    controllers[n] = ships[#ships]
  end
end
