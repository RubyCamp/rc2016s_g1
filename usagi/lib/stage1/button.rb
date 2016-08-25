require_relative 'character'

class Button < Character

  def self.flg
    @@flg
  end

  def initialize(cell_x, cell_y, id)
    image = Image.load(image_path("btn#{id+1}.png"))
#    image = Image.load("images/enemy.png")
    image.set_color_key(C_WHITE)
    super(cell_x , cell_y, image)
    @id = id
    @@flg ||= []
    @@flg << false
  end

  def hit(obj)
    if obj.is_a?(Player)
      if @id-1 < 0 || @@flg[@id-1]
        @@flg[@id] = true
        p @@flg
      end
    end
  end




end