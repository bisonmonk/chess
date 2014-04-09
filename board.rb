require "piece.rb"
require "pawn.rb"
require "sliding_piece.rb"
require "stepping_piece.rb"

# Board.rb

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

class Board
  attr_accessor :grid#contains Piece or nil if no Piece

  def initialize(setup)
    @grid = Array.new(8) { Array.new(8, nil)}

    if setup
      #setup pieces
    end
  end

  def setup_pieces


  #Returns whether a player is in check
  def in_check?(color)
    #find the position of the king on the board then,
    #see if any of the opposing pieces can move to that
    #position
  end

  #If the player is in check, and if none of the player's pieces
  #have any #valid_moves, then the player is in checkmate.
  def checkmate?(color)

  end

  def at(pos)
    row, col = pos
    self.grid[row][col]
  end

  def empty?(pos)
    self.at(pos).nil?
  end

  #updates the 2d grid and also the moved piece's
  #position

  #Raises exception if no piece at start
  # ||
  #piece cannot move to end_pos

  #Board#move should raise an exception if it would leave you in check.
  def move(start, end_pos)
    #if its a pawn and its the first move set Pawn.first_move = false
    #after move is made
  end

  ##valid_moves needs to make a move on the duped board to see
  #if a player is left in check.
  #Method Board#move! makes a move without checking if it is valid.
  def move!(start, end_pos)
  end

  #should duplicate not only the Board, but
  #the pieces on the Board
  #Ruby's #dup method does not call dup on the instance variables,
  #so you may need to write your own Board#dup method
  #that will dup the individual pieces as well.
  def dup
    #after duplicating board,
  end
end


