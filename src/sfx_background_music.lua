local sfx_background_music = {
  love.audio.newSource('share/chasersgaming_spaceranger3.ogg', 'stream'),
}
sfx_background_music[1]:setLooping(true)

function sfx_background_music:on()
  if not self[1]:isPlaying() then love.audio.play(self[1]) end
end

function sfx_background_music:off()
  if self[1]:isPlaying() then love.audio.stop(self[1]) end
end

return sfx_background_music
