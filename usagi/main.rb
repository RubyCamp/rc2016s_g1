require 'dxruby'
require_relative 'lib/director'

Window.width = 800  # 32px * 25マス
Window.height = 600 # 32px * 17マス + 画面下部のスペース(54px)

Window.loop do
  Director.instance.play

  break if Input.key_push? K_ESCAPE
end