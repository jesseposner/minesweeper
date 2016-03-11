require 'byebug'

class Game
  def initialize(size: 9, bombs: 10)
    @board = Board.new(size, bombs)
  end

  def get_guess
    puts "What's your guess?"
    guess = parse_guess(gets.chomp)
    until valid_guess?(guess)
      puts "What's your guess?"
      guess = parse_guess(gets.chomp)
    end
  end

  def parse_guess(guess)
    guess.split(",").map!(&:to_i)
  end

  def valid_guess?(guess)
    guess.length == 2 &&
      guess.all? { |el| (0...@board.size).include?(el) }
  end

end


class Board
  def initialize(size, bombs)
    @grid = Array.new(size) { Array.new(size) { Tile.new } }
    assign_bombs(bombs)
  end

  def assign_bombs(bombs)
    bomb_positions = []
    until bomb_positions.length == bombs
      x = rand(@grid.length)
      y = rand(@grid.length)
      bomb_positions << [x,y] unless bomb_positions.include?([x,y])
    end
    bomb_positions.each { |pos| self[pos].set_bomb }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def reveal(pos)
    game_over if self[pos].bomb
  end

  def game_over

  end

  def size
    @grid.length
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
