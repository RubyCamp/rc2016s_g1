class Character < Sprite
  attr_reader :cell_x, :cell_y

  def initialize(cell_x, cell_y, image)
    @image = image
    @cell_x = cell_x
    @cell_y = cell_y
    super(@cell_x * @image.width, @cell_y * @image.height, @image)
  end

  # 「キーワード引数」を使っています
  def move_cell(dx: nil,dy: nil)
    if dx
      @cell_x += dx
      self.x += dx * @image.width
    end
    if dy
      @cell_y += dy
      self.y += dy * @image.height
    end
  end

  private

  def image_path(filename)
    return File.join(File.dirname(__FILE__), "..", "images", filename)
  end
end
