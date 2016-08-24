require_relative 'character'

# 追いかけてくるけど、対角線上では待ち伏せする敵（緑）
class Enemy < Character
  UPDATE_THRESHOLD = 20 # 20フレームごとに移動する

  def initialize(cell_x, cell_y)
    image = Image.load(image_path("enemy.png"))
    image.set_color_key(C_WHITE)
    super(cell_x , cell_y, image)
    @count = 0
  end

  def update
    if @count < UPDATE_THRESHOLD
      @count += 1
      return
    end
    @count = 0

    move
  end

  private

  # X軸とY軸でプレイヤーと距離が遠い方をしらべて、
  # その軸優先でプレイヤーの方向に移動する。
  # 対角線上にいるときは移動しない。
  def move
    map = Director.instance.map
    player = Director.instance.player
    player_dx = player.cell_x - @cell_x
    player_dy = player.cell_y - @cell_y
    if player_dx.abs > player_dy.abs
      dx = player_dx / player_dx.abs
      if map.movable?(@cell_x + dx, @cell_y)
        move_cell(dx: dx)
      elsif !player_dy.zero?
        dy = player_dy / player_dy.abs
        move_cell(dy: dy) if map.movable?(@cell_x, @cell_y + dy)
      end
    elsif player_dx.abs < player_dy.abs
      dy = player_dy / player_dy.abs
      if map.movable?(@cell_x, @cell_y + dy)
        move_cell(dy: dy)
      elsif !player_dx.zero?
        dx = player_dx / player_dx.abs
        move_cell(dx: dx) if map.movable?(@cell_x + dx, @cell_y)
      end
    end
  end
end
