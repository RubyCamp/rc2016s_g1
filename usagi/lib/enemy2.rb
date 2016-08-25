require_relative 'character'

# 最短経路で近づいてくる敵（赤）
class Enemy2 < Character
  UPDATE_THRESHOLD = 40 # 40フレームごとに移動する（おそい）

  def initialize(cell_x, cell_y)
    image = Image.load(image_path("enemy2.png"))
    image.set_color_key(C_WHITE)
    super(cell_x , cell_y, image)
    @count = 0
  end

  def update
    if @count < UPDATE_THRESHOLD * $Item_time
      @count += 1
      return
    end
    @count = 0
    item_time_judg
    move
  end

  private

  def move
    map = Director.instance.map
    player = Director.instance.player
    start = [@cell_x, @cell_y]
    goal = [player.cell_x, player.cell_y]
    route = map.calc_route(start, goal)
    dest = route[1]
    if dest
      dx = dest[0] - @cell_x
      dy = dest[1] - @cell_y
      move_cell(dx: dx, dy: dy)
    end
  end
end
