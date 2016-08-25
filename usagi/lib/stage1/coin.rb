require_relative 'character'

class Coin < Character
  def initialize(x, y)
    image = Image.load(image_path("coin.png"))
    image.set_color_key(C_WHITE)
    super(x, y, image)
  end

  def hit(obj)
    vanish
  end
end
