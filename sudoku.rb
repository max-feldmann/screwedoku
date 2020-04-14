require "colorize"

puts "MUAHAHA.  The dastardly unexpected end statement.\n".red
puts "Do NOT try to solve this error by going one method at a time and looking for an 'end'.\n".red
puts "Instead, comment out half of the bad file at a time until the error changes.  Keep narrowing down from there.".red
puts ""
puts "Does this approach feel familiar?  The approach is a version of binary search.\n\n".red

require_relative "board"

# People write terrible method names in real life.
# On the job, it is your job to figure out how the methods work and then name them better.
# Do this now.

class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def get_pos
    pos = nil
    until pos && correct_pos?(pos)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        pos = parse_pos(gets.chomp)
      rescue
        puts "Invalid position entered (did you use a comma?)"
        puts ""

        pos = nil
      end
    end
    pos
  end

  def get_val
    val = nil
    until val && correct_val?(val)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "
      val = parse_val(gets.chomp)
    end
    val
  end

  def parse_pos(string)
    string.split(",").map { |char| Integer(char) }
  end

  def parse_val(string)
    Integer(string)
  end

  def make_turn
    place_val(get_pos, get_val)
  end

  def place_val(p, v)
    board[p] = v
  end

  def run
    until solved?
      board.render
      make_turn
    end
    puts "Congratulations, you win!"
  end

  def solved?
    board.solved?
  end

  def correct_pos?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
  end

  def correct_val?(val)
    val.is_a?(Integer) &&
      val.between?(0, 9)
  end

  private
  attr_reader :board
end


game = SudokuGame.from_file("puzzles/sudoku1.txt")
game.run
