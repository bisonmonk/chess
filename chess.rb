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

class Piece
  attr_accessor :pos, :board

  #returns an array of all place a
  #piece can move to
  def moves
    #don't allow a piece to move into a square already
    #occupied by a piece of the same color
  end

  #Write Board#dup before writing this method!!!!!!!!!!
  #Board#move calls this method therefore valid_moves MUST NOT CALL Board#move!!!
  def valid_moves

  end

  #Filters out the #moves of a Piece that would leave
  #the player in check:
  def move_into_check?(pos)
    #1. Duplicates the Board and performs the move(Board#dup)
    #2. Looks to see if the player is in check after
    #   the move (Board#in_check?).
  end

  #ASK IF THIS IS LEGIT BEFORE IMPLEMENTATION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  #Ruby's #dup method does not call dup on the instance variables,
  #so you may need to write your own Board#dup method that will dup
  #the individual pieces as well.
  #!!!!!!!!!!!!!!!!
  #If your piece holds a reference to the original board,
  #you will need to update this reference to the new dupped board.
  #Failure to do so will cause your duped board to generate incorrect moves!
  def dup

  end
end

class SlidingPiece < Piece

  #each SlidingPiece subclass (B,R,Q)
  #will use move_dirs in it's move method
  def move_dirs
  end
end

class Bishop < SlidingPiece
end

class Rook < SlidingPiece
end

class Queen < SlidingPiece
end

class SteppingPiece < Piece

end

#DO THIS LAST CUZ NED SED SO
class Pawn < Piece

end

class Board
  attr_accessor :grid#contains Piece or nil if no Piece


  def in_check?(color)
  end

  #If the player is in check, and if none of the player's pieces
  #have any #valid_moves, then the player is in checkmate.
  def checkmate?

  end

  #updates the 2d grid and also the moved piece's
  #position
  #Raises exception if no piece at start || piece
  #cannot move to end_pos
  #Board#move should raise an exception if it would leave you in check.
  def move(start, end_pos)
  end

  ##valid_moves needs to make a move on the duped board to see
  #if a player is left in check.
  #Method Board#move! makes a move without checking if it is valid.
  def move!
  end

  #should duplicate not only the Board, but
  #the pieces on the Board
  #Ruby's #dup method does not call dup on the instance variables,
  #so you may need to write your own Board#dup method
  #that will dup the individual pieces as well.
  def dup
  end
end


#constructs a Board object, that alternates between
#players (assume two human players for now) prompting
#them to move. The Game should handle exceptions from
#Board#move and report them.
class Game
  attr_accessor :board

end

#Game#play method just continuously calls play_turn
#READ TIPS AT BOTTOM OF CHESS SPEC
class HumanPlayer

  def play_turn
  end
end