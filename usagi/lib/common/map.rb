﻿require_relative 'dijkstra_search'

class Map
  # マップチップ毎の画像イメージ
  

  # @map_data の各要素の意味
  FLOOR = 0
  WALL = 1

  def initialize(map_file, map_chip_name)
    @map_data = []
    map_load(map_file)
    @cell_images = Image.loadToArray(File.join(File.dirname(__FILE__), "..","..", "images", map_chip_name), 4, 4)
  end

  # マップ全体の描画
  def draw
    @map_x_size.times do |x|
      @map_y_size.times do |y|
        draw_cell(x, y)
      end
    end
  end

  # 任意の座標x, y におけるマップチップの種類を取得
  def [](x, y)
    return @map_data[y][x].to_i
  end

  def movable?(x, y)
    return false if x < 0 || x >= @map_x_size || y < 0 || y >= @map_y_size
    return self[x,y] == 0
  end

  def height
    return @map_y_size * @cell_images.first.height
  end

  # 引数で指定されたスタートからゴールへの最短経路を計算する
  # start:  移動開始位置の座標、[x, y] の形式
  # goal:   移動終了位置の座標、[x, y] の形式
  # 戻り値: goalまでのルートがあれば、そこまでの移動経路を配列で返す
  #
  #           [start, [x1, y1], [x2, y2], ... , goal]
  #
  #         goalまでのルートが無ければ、開始位置のみを含む配列を返す
  #
  #           [start]
  def calc_route(start, goal)
    g = Graph.new(make_data)
    start_id = "m#{start[0]}_#{start[1]}"
    goal_id = "m#{goal[0]}_#{goal[1]}"
    g.get_route(start_id, goal_id)
  end

  private

  # マップデータの読み込み
  def map_load(map_file)
    open(map_file).each do |line|
      cols = line.chomp.split(/\s*,\s*/).map(&:to_i)
      @map_data << cols
      @map_x_size = cols.size unless @map_x_size
    end
    @map_y_size = @map_data.size
  end

  # マップの1マスの描画
  def draw_cell(x, y)
    image = @cell_images[self[x, y]]
    Window.draw(x * image.width, y * image.height, image)
  end

  # 経路探索用のグラフの元データを作成
  def make_data
    data = {}
    @map_y_size.times do |y|
      @map_x_size.times do |x|
        nid_and_costs = []
        [[x, y - 1], [x, y + 1], [x - 1, y], [x + 1, y]].each do |dest_x, dest_y|
          if dest_x < 0 || dest_x > @map_x_size - 1 ||
             dest_y < 0 || dest_y > @map_y_size - 1 ||
             !movable?(x, y)
            next
          end
          case @map_data[dest_y][dest_x]
          when FLOOR
            nid_and_costs << ["m#{dest_x}_#{dest_y}", 1]
          when WALL
            # 壁は通れないのでエッジを追加しない
            nid_and_costs
          end
        end
        data["m#{x}_#{y}"] = nid_and_costs
      end
    end
    return data
  end
end
