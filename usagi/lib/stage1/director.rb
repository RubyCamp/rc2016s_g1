﻿require 'singleton'
require_relative '../common/map'
require_relative 'info_window'
require_relative 'player'
require_relative 'enemy'
require_relative 'enemy2'
require_relative 'enemy3'
require_relative 'enemy4'
require_relative 'coin'
require_relative 'item3'
require_relative 'button'

module Stage1
class Director
  include Singleton
  attr_reader :map, :player

  TIME_LIMIT = 60 # ゲーム終了までの秒数

  def initialize

    @start_time = Time.now
    @count = TIME_LIMIT

    @map = Map.new(File.join(File.dirname(__FILE__), "..","..", "images", "map1.dat"), "map_chips1.png")
    @info_window = InfoWindow.new(@map.height, @count)
    @characters = []
    @coins = []
    1.times do
      point = [rand(1..24), rand(1..16)]
      # 移動不可能なマスか、すでにコインが配置されているマスの場合はやり直す
      if !@map.movable?(*point) ||
         @coins.any?{|coin| [coin.cell_x, coin.cell_y] == point}
        redo
      end
      @coins << Coin.new(*point)
    end
    @characters += @coins
    @enemies = []
    @enemies << Enemy.new(11,3)
    @enemies << Enemy2.new(12,3)
    @enemies << Enemy3.new(13,3)
    @enemies << Enemy4.new(14,3)

    @buttons = []
    @buttons << Button.new(13,13,0)
    @buttons << Button.new(14,13,1)
    @buttons << Button.new(15,13,2)
    @buttons << Button.new(16,13,3)

    @characters += @enemies
    @player = Player.new
    @characters << @player
    @characters += @buttons
  end

  def play
    # ゲームオーバーになったら描画以外のことはしない
    unless game_over?
      count_down
      Sprite.update(@characters)
      Sprite.check(@enemies, @player, :hit, :attacked)
      Sprite.check(@player, @coins)
      compact
    end

    @map.draw
    @info_window.draw
    Sprite.check(@coins, @enemies)
    Sprite.check(@enemys,@item3)
    Sprite.check(@player, @buttons)
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
end
