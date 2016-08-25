require_relative 'character'

# 霑ｽ縺・°縺代※縺上ｋ縺代←縲∝ｯｾ隗堤ｷ壻ｸ翫〒縺ｯ蠕・■莨上○縺吶ｋ謨ｵ・育ｷ托ｼ・
class Enemy < Character
  UPDATE_THRESHOLD = 60 # 60繝輔Ξ繝ｼ繝縺斐→縺ｫ遘ｻ蜍輔☆繧・

  def initialize(cell_x, cell_y)
    image = Image.load(image_path("enemy.png"))
    image.set_color_key(C_WHITE)
    super(cell_x , cell_y, image)
    @count = 0
    @update_threshold = UPDATE_THRESHOLD
  end

  def update
    if @count < @update_threshold
      @count += 1
      return
    end
    @count = 0

    move
  end

  def hit(obj)
    if obj.is_a?(Coin)
      @update_threshold = 120
    end
    if obj.is_a?(item3)
      vanish
    end
  end

  private

  # X霆ｸ縺ｨY霆ｸ縺ｧ繝励Ξ繧､繝､繝ｼ縺ｨ霍晞屬縺碁□縺・婿繧偵＠繧峨∋縺ｦ縲・
  # 縺昴・霆ｸ蜆ｪ蜈医〒繝励Ξ繧､繝､繝ｼ縺ｮ譁ｹ蜷代↓遘ｻ蜍輔☆繧九・
  def move
    map = Director.instance.map
    player = Director.instance.player
    player_dx = player.cell_x - @cell_x
    player_dy = player.cell_y - @cell_y
    if player_dx.abs > player_dy.abs
      dx = player_dx / player_dx.abs
        move_cell(dx: dx)
    elsif player_dx.abs < player_dy.abs
      dy = player_dy / player_dy.abs
        move_cell(dy: dy)
    else
      dx = player_dx / player_dx.abs
      dy = player_dy / player_dy.abs
      move_cell(dx: dx,dy: dy)
    end
  end
end
