local _ = require('src.const_libretro')
local asteroid = require('src.asteroid')
local ship = require('src.ship')
local window = require('src.window')

local asteroids = {}
local bullets = {}
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
  end
  for x = #bullets, 1, -1 do
    local o = bullets[x]
    o:update(dt)
    o:wrap(window)
    if o.time_left <= 0 then table.remove(bullets, x) end
  end
  for _, o in ipairs(ships) do
    local bullet = o:control(dt)
    if bullet then table.insert(bullets, bullet) end
    o:update(dt)
    o:wrap(window)
  end
end

function love.draw()
  for y = -1, 1 do
    for x = -1, 1 do
      for _, o in ipairs(asteroids) do o:draw(x * window.width, y * window.height) end
      for _, o in ipairs(bullets) do o:draw(x * window.width, y * window.height) end
      for _, o in pairs(ships) do o:draw(x * window.width, y * window.height) end
    end
  end
end

function love.joystickpressed(n, b)
  n, b = n + 1, b + 1
  if b == RETRO_DEVICE_ID_JOYPAD_START and not ships[n] then
    ships[n] = ship:new{ controller_number = n, x = window.width / 2, y = window.height / 2 }
  end
end
