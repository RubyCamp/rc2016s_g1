require_relative 'character'

# プレイヤーのあとをつけてくる敵（紫）
class Enemy3 < Character
  UPDATE_THRESHOLD = 10 # 10フレームごとに移動する（はやい）
  PAST_DEPTH = 7 # どれだけ過去のプレイヤーの位置を追うか

  def initialize(cell_x, cell_y)
    image = Image.load(image_path("enemy3.png"))
    image.set_color_key(C_WHITE)
    super(cell_x , cell_y, image)
    @count = 0
    @player_pos_logs = []
  end

  def update
    if @count < UPDATE_THRESHOLD
      @count += 1
      return
    end
    @count = 0

    # プレイヤーの位置を覚えておく。古くなったのは捨てる
    player = Director.instance.player
    @player_pos_logs << [player.cell_x, player.cell_y]
    @player_pos_logs.shift if @player_pos_logs.size > PAST_DEPTH

    move
  end

  private

  def move
    map = Director.instance.map
    start = [@cell_x, @cell_y]
    goal = @player_pos_logs.first
    route = map.calc_route(start, goal)
    dest = route[1]
    if dest
      dx = dest[0] - @cell_x
      dy = dest[1] - @cell_y
      move_cell(dx: dx, dy: dy)
    end
  end
end
