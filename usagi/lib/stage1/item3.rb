require_relative 'character'

class Item3 < Character
  def initialize(x, y)
    @item3flag = 0
    image = Image.load(image_path("coin.png"))
    image.set_color_key(C_WHITE)
    super(x, y, image)
  end

  def hit(obj)
      @item3flag = 1
  end
end
