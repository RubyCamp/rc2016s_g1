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
		if dx.abs >= 2
			step_x = (dx < 0 ? -1:1)

			dx.abs.times do 
				@cell_x += step_x
      	 		self.x += step_x * @image.width
				Sprite.check(self,Director.instance.player,:shot,:attacked)
			end

		else
     	 	@cell_x += dx
      	 	self.x += dx * @image.width
		end
    end
    if dy
		if dy.abs >= 2
			step_y = (dy < 0 ? -1:1)

			dy.abs.times do 
				@cell_y += step_y
      	 		self.y += step_y * @image.width
				Sprite.check(self,Director.instance.player,:shot,:attacked)
			end

		else
     	 	@cell_y += dy
      	 	self.y += dy * @image.width
		end
	end
  end

  private

  def image_path(filename)
    return File.join(File.dirname(__FILE__), "..", "images", filename)
  end
end