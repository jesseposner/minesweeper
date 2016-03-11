require 'byebug'

class Board
  def initialize(size: 9, bombs: 10)
    @grid = Array.new(size) { Array.new(size) { Tile.new } }
    assign_bombs(bombs)
  end

  def assign_bombs(bombs)
    bomb_positions = []
    until bomb_positions.length == bombs
      x = rand(@grid.length)
      y = rand(@grid.length)
      bomb_positions << [x,y]
      bomb_positions.uniq!
    end
    bomb_positions.each { |pos| self[pos].set_bomb }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end
end

class Tile
  attr_reader :number, :bomb, :flag, :revealed

  def initialize
    @bomb = false
    @flag = false
    @revealed = false
    @number = nil
  end

  def set_bomb
    @bomb = true
  end

  def set_flag
    @flag = true
  end

  def set_number(num)
    @number = num
  end

  def unset_flag
    @flag = false
  end

  def reveal
    @revealed = true
  end
end
