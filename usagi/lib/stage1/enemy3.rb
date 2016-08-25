require_relative 'character'

# 最短経路で1-3マスランダムで近づいてくる敵（赤）
class Enemy3 < Character
  UPDATE_THRESHOLD = 40 # 40フレームごとに移動する（おそい）

  def initialize(cell_x, cell_y)
    image = Image.load(image_path("enemy3.png"))
    image.set_color_key(C_WHITE)
    super(cell_x , cell_y, image)
    @count = 0
  end

  def update
    if @count < UPDATE_THRESHOLD * $item_time
      @count += 1
      return
    end
    @count = 0
    item_time_judg
    move
  end
 def hit(obj)
  if obj.is_a?(Item3)
    vanish
  end
 end
  private

  def move
    map = Stage1::Director.instance.map
    player = Stage1::Director.instance.player
	rand_num = rand(0..2)

    start = [@cell_x, @cell_y]
    goal = [player.cell_x, player.cell_y]
    route = map.calc_route(start, goal)
    dest = route[1]
    if dest
      dx = dest[0] - @cell_x
      dy = dest[1] - @cell_y

	  if dx != 0	#各方向への移動
		  if  dx == 1
		 	 for i in 0..rand_num
				  if map.movable?(@cell_x + dx + i, @cell_y)
					  move_x = dx + i
				  else
					  break
				  end
		 	 end
		  else
			 for i in 0..rand_num
				  if map.movable?(@cell_x + dx - i, @cell_y)
					  move_x = dx - i
				  else
					  break
				  end
		 	 end
		  end
	  else
		  if  dy == 1
		 	 for i in 0..rand_num
				  if map.movable?(@cell_x, @cell_y + dy + i)
					  move_y = dy + i
				  else
					  break
				  end
		 	 end
		  else
			 for i in 0..rand_num
				  if map.movable?(@cell_x, @cell_y + dy - i)
					  move_y = dy - i
				  else
					  break
				  end
		 	 end
		  end
	  end
	move_cell(dx: move_x,dy: move_y)
	end
  end
end