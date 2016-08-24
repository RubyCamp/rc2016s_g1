require_relative 'character'

# 追いかけてくるけど、対角線上では待ち伏せする敵（緑）
class Enemy < Character
  UPDATE_THRESHOLD = 60 # 60フレームごとに移動する

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
  end

  private

  # X軸とY軸でプレイヤーと距離が遠い方をしらべて、
  # その軸優先でプレイヤーの方向に移動する。
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
