local gfx_bad_ships = {
  texture1 = love.graphics.newImage('share/titmouse001_bad_ships_a.png'),
  texture2 = love.graphics.newImage('share/titmouse001_bad_ships_b.png'),
  quads = {},
  ship1 = {},
  ship2 = {},
  explosion1 = {},
  explosion2 = {},
  satellite = {},
}
for y = 0, 240, 16 do for x = 0, 304, 16 do
  table.insert(gfx_bad_ships.quads, love.graphics.newQuad(x, y, 16, 16, 320, 256))
end end
local n = 54
for x = 1, 72 do
  gfx_bad_ships.ship1[n % 72] = gfx_bad_ships.quads[x]
  gfx_bad_ships.ship2[n % 72] = gfx_bad_ships.quads[x + 72]
  n = n + 1
end
for n = 145, 153 do table.insert(gfx_bad_ships.explosion1, gfx_bad_ships.quads[n]) end
for n = 155, 163 do table.insert(gfx_bad_ships.explosion2, gfx_bad_ships.quads[n]) end

return gfx_bad_ships
