require 'dxruby'

require_relative 'scene'
require_relative 'lib/load_scenes'


Window.width = 800  # 32px * 25マス
Window.height = 600 # 32px * 17マス + 画面下部のスペース(54px)

Scene.set_current_scene(:stage1)

Window.loop do
  break if Input.key_push? K_ESCAPE

  Scene.play_scene
end