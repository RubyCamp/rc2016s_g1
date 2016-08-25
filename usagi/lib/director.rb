require 'singleton'
require_relative 'map'
require_relative 'info_window'
require_relative 'player'
require_relative 'item3'
require_relative 'enemy'
require_relative 'enemy2'
require_relative 'enemy3'
require_relative 'enemy4'
require_relative 'coin'
require_relative 'enemy_stop_item'

class Director
  include Singleton
  attr_reader :map, :player

  TIME_LIMIT = 60 # ゲーム終了までの秒数

  def initialize
    @start_time = Time.now
    @count = TIME_LIMIT

    @map = Map.new(File.join(File.dirname(__FILE__), "..", "images", "map.dat"))
    @info_window = InfoWindow.new(@map.height, @count)
    @characters = []
    @coins = []
    @enemy_stop_items = []
    3.times do
      point = [rand(1..18), rand(1..13)]
      # 移動不可能なマスか、すでにコインが配置されているマスの場合はやり直す
      if !@map.movable?(*point) ||
         @coins.any?{|coin| [coin.cell_x, coin.cell_y] == point}
        redo
      end
      @coins << Coin.new(*point)
    end
    3.times do
      point = [rand(1..18), rand(1..13)]
      # 移動不可能なマスか、すでにコインが配置されているマスの場合はやり直す
      if !@map.movable?(*point) ||
        @enemy_stop_items.any?{|enemy_stop_item| [enemy_stop_item.cell_x, enemy_stop_item.cell_y] == point}
        redo
      end
      @enemy_stop_items << EnemyStopItem.new(*point)
    end
    @characters += @coins
    @enemies = []
    @enemies << Enemy.new(11,1)
    @enemies << Enemy2.new(11,1)
    @enemies << Enemy3.new(11,1)
    @enemies << Enemy4.new(11,1)
    @characters += @enemies
    @player = Player.new
    @characters << @player
    @characters += @enemy_stop_items
  end

  def play
    # ゲームオーバーになったら描画以外のことはしない
    unless game_over?
      count_down
      Sprite.update(@characters)
      Sprite.check(@enemies, @player, :hit, :attacked)
      Sprite.check(@player, @coins)
      if Sprite.check(@player, @enemy_stop_items)
        @enemies[0].slow
      end
      compact
    end

    @map.draw
    @info_window.draw
    Sprite.check(@coins, @enemies)
#    Sprite.check(@enemy_stop_items, @enemies)
    Sprite.check(@enemys,@item3)
    Sprite.draw(@characters)
  end

  private
  def count_down
    @count = TIME_LIMIT - (Time.now - @start_time).to_i
    @info_window.count = @count
  end

  # 下記のいずれかの状態になったらゲーム終了
  #
  # ・ゲーム開始から <TIME_LIMIT> 秒が経過する
  # ・プレイヤーのライフが 0 になる
  # ・すべてのコインを取る
  def game_over?
    return @count <= 0 || @player.life <= 0 || @coins.empty?
  end

  def compact
    [@coins, @enemies, @characters].each do |sprites|
      sprites.reject!{|sprite| sprite.vanished? }
    end
  end
end
