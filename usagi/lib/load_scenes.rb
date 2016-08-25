#require_relative 'title/director'
require_relative 'stage1/director'
#require_relative 'stage2/director'
#require_relative 'stage3/director'
#require_relative 'ending/director'

#Scene.add_scene(Title::Director.new,  :title)
Scene.add_scene(Stage1::Director.instance,  :stage1)
#Scene.add_scene(Stage2::Director.new,  :stage2)
#Scene.add_scene(Stage3::Director.new,  :stage3)
#Scene.add_scene(Ending::Director.new,  :ending)
