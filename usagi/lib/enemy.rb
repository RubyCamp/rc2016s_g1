require_relative 'character'

# čæ½ćEćć¦ćććć©ćåÆ¾č§ē·äøć§ćÆå¾E”ä¼ćććęµEē·ļ¼E
class Enemy < Character
  UPDATE_THRESHOLD = 60 # 60ćć¬ć¼ć ććØć«ē§»åććE

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
    if obj.is_a?(Item3)
      vanish
    end
  end

  private

  # Xč»øćØYč»øć§ćć¬ć¤ć¤ć¼ćØč·é¢ćé ćE¹ćććć¹ć¦ćE
  # ććEč»øåŖåć§ćć¬ć¤ć¤ć¼ć®ę¹åć«ē§»åćććE
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
