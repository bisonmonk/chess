# encoding: utf-8

load "piece.rb"
load "pawn.rb"
load "sliding_piece.rb"
load "stepping_piece.rb"
load "board.rb"
require 'debugger'

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


class Game
  attr_accessor :board, :turn, :to_symbol, :move_hash
  attr_accessor :p1, :p2


  def initialize(p1 = nil, p2 = nil)

    @board = Board.new(true)
    @turn = :white

    @p1 ||= HumanPlayer.new
    @p2 ||= HumanPlayer.new

    @to_symbol = {
    :white => { King => '♔',
                Queen => '♕',
                Rook => '♖',
                Bishop => '♗',
                Knight => '♘',
                Pawn => '♙',
                :square => '□'
              },

    :black => { King => '♚',
                Queen => '♛',
                Rook => '♜',
                Bishop => '♝',
                Knight => '♞',
                Pawn => '♟',
                :square => '■'
              }
            }
    @move_hash = build_move_hash

    self.play
  end

  def play
    until self.board.checkmated?(:white)# || self.board.checkmated?(:black)
      play_turn
      turn = opposing_color(turn)
    end

    puts "Checkmate! #{ opposing_color(self.turn) } wins!"
  end

  def play_turn
    # display board
    display_board
    # prompt self.turn player for move
    # ADD NAME HERE
    begin
      puts "#{self.turn}, which piece do you want to move? (letter, number)"
      move_from = parse_move(gets.chomp)

      print "to? (letter, number)"
      move_to = parse_move(gets.chomp)

      self.board.move(move_from, move_to)
      self.turn = opposing_color(self.turn)
    rescue StandardError => e
      puts e
      retry
    end
      # using their name
    # parse move
    # make move
      # handle move exceptions with begin/rescue/retry
  end

  def build_move_hash
    move_hash = {}
    col = 0
    ('a'..'h').to_a.each do |letter|
      8.downto(1).to_a.each do |row|
        move = letter + row.to_s
        move_hash[move] = [8-row, col]
      end
      col += 1
    end
    move_hash
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
    square_color = :black

    puts "    #{self.p2.name}"
    puts
    (0...brd.length).each do |row|
      square_color = opposing_color(square_color)
      print "#{8 - row} "
      (0...brd[row].length).each do |col|
        square = self.board.at([row, col])
        if square.is_a?(Piece)
          print self.to_symbol[square.color][square.class] + ' '
        else
          print self.to_symbol[square_color][:square] + ' '
        end
        square_color = opposing_color(square_color)
      end
      print "\n"
    end
    puts "  a b c d e f g h"
    puts "\n     #{self.p1.name}"

  end

  def parse_move(pos)
    # feed from into hash
    self.move_hash[pos]
  end

  def make_move(start, end_pos)
    self.board.move(start, end_pos)
  end

  # def current_player
  #   self.p1.name if :white == self.turn
  #   self.p2.name if :black == self.turn
  # end

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
    return real_name
  end

end

g = Game.new(true)
