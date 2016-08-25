# 画面下の得点とかを表示する領域
class InfoWindow
  attr_writer :count

  def initialize(margin_y, count)
    @margin_y = margin_y
    @font = Font.new(32)
    @count = count
  end

  def draw
    player = Stage1::Director.instance.player
    Window.draw_font(10, @margin_y + 10, "得点: #{player.score}", @font)
    Window.draw_font(200, @margin_y + 10, "ライフ: #{player.life}", @font)
    Window.draw_font(400, @margin_y + 10, "残り時間: #{@count}", @font)
  end
end
