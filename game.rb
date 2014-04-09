# Game.rb

#  * a b c d e f g h  *
#  -------------------
#8 | r k b K Q b k R | 8
#7 | p p p p p p p p | 7
#6 | - - - - - - - - | 6
#5 | - - - - - - - - | 5
#4 | - - - - - - - - | 4
#3 | - - - - - - - - | 3
#2 | p p p p p p p p | 2
#1 | r k b K Q b k R | 1
#  -------------------
#  * a b c d e f g h  *

#constructs a Board object, that alternates between
#players (assume two human players for now) prompting
#them to move. The Game should handle exceptions from
#Board#move and report them.

# encoding: utf-8

class Game
  attr_accessor :board, :turn


  def initialize(p1 = HumanPlayer.new, p2 = HumanPlayer.new)
    @board = Board.new(true)
    @turn = :white

    self.play
  end

  def play
    until checkmate?(:white) || checkmate?(:black)
      play_turn
      turn = opposing_color(turn)
    end
  end

  def play_turn
    # display board
    # prompt self.turn player for move
      # using their name
    # parse move
    # make move
      # handle move exceptions with begin/rescue/retry
  end

  def opposing_color(color)
    if color == :white
      :black
    else
      :white
    end
  end

  def display_board
    brd = self.board.grid
    (0...brd.length).each do |row|
      (0...brd[row].length).each do |col|
        square = self.board.at[row][col]
        if square == nil
          # Do we want default values that are overridden?
          # Or prev_square that switches off black/white
        print square
      end
      puts
    end

  end

  def parse_move
  end

  def make_move(start, end)
    self.board.move(start, end)
  end

end






#Game#play method just continuously calls play_turn
#READ TIPS AT BOTTOM OF CHESS SPEC
class HumanPlayer
  attr_accessor :name

  def initialize
    @name = prompt_for_name
  end

  def prompt_for_name
    names = ["Bobby Fischer", "Garry Kasparov", "Barry Kasparov", "Deep Blue", "Magnus",
      "Buddy"]
    puts "Please enter your name: "
    input = gets.chomp
    real_name = names.sample
    puts "That's a nice name, but I'm gonna call you #{real_name}. You better be good at this
    #{real_name}."
    real_name
  end

end