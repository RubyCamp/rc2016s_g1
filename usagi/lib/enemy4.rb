require_relative 'character'

# ランダムに徘徊する敵（B）
class Enemy4 < Character
  UPDATE_THRESHOLD = 30 # 30フレームごとに移動する（はやい）
  KEEP_DEST_TURN = 4 # 移動先を更新するまでのターン数

  def initialize(cell_x, cell_y)
    image = Image.load(image_path("enemy4.png"))
    image.set_color_key(C_WHITE)
    super(cell_x , cell_y, image)
    @count = UPDATE_THRESHOLD
    @kept_turn = KEEP_DEST_TURN + 1
  end

  def update
    if @count < UPDATE_THRESHOLD
      @count += 1
      return
    end
    @count = 0

    update_dest
    move
  end
 def hit(obj)
  if obj.is_a?(Item3)
    vanish
  end
 end
  private

  def update_dest(force=false)
    if force || @kept_turn > KEEP_DEST_TURN
      map = Director.instance.map
      loop do
        dest_x = rand(1..18)
        dest_y = rand(1..13)
        distance = (@cell_x - dest_x) ** 2 + (@cell_y - dest_y) ** 2
        # 立ち止まることが無い様に、移動先への距離が保持ターン数以上のセル数であることを確認
        if map.movable?(dest_x, dest_y) && distance >= KEEP_DEST_TURN ** 2
          @dest = [dest_x, dest_y]
          break
        end
      end
      @kept_turn = 0
    else
      @kept_turn += 1
    end
  end

  def move
    map = Director.instance.map
    start = [@cell_x, @cell_y]
    goal = @dest
    route = map.calc_route(start, goal)
    dest = route[1]
    if dest
      dx = dest[0] - @cell_x
      dy = dest[1] - @cell_y
      move_cell(dx: dx, dy: dy)
    end
  end
end
