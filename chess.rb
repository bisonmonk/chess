# SPLIT INTO SEPARATE FILES AS OF COMMIT [master 29972ce]

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
  attr_accessor :pos, :board, :color

  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end

  #returns an array of all place a
  #piece can move to
  def moves
    #don't allow a piece to move into a square already
    #occupied by a piece of the same color
    # ||
    #or move a sliding piece past a piece that blocks it

    raise "Cannot implement moves for a general Pieces"
    #should return an array of place this piece can move to
  end

  #Write Board#dup before writing this method!!!!!!!!!!
  #Board#move calls this method therefore valid_moves MUST NOT CALL Board#move!!!
  def valid_moves
    #filters out he #moves of a Piece that would leave the player in check
  end

  #Filters out the #moves of a Piece that would leave
  #the player in check:
  def move_into_check?(pos)
    #1. Duplicates the Board, i.e. #dup
    #2. Performs the move on the duped_board (Board#dup)
    #                         start, end_pos
    #     duped_board.move(self.pos, pos)   (bc self is on original board)
    #3. Looks to see if the player is in check after
    #   the move (duped_board#in_check?).
  end

  #ASK IF THIS IS LEGIT BEFORE IMPLEMENTATION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  #Ruby's #dup method does not call dup on the instance variables,
  #so you may need to write your own Board#dup method that will dup
  #the individual pieces as well.
  #!!!!!!!!!!!!!!!!
  #If your piece holds a reference to the original board,
  #you will need to update this reference to the new dupped board.
  #Failure to do so will cause your duped board to generate incorrect moves!

  #Must pass the newly duped board to place duped Pieces
  #on duped board
  def dup(duped_board)
    #assign self.board to duped_board
  end

  def get_new_pos(pos1, pos2)
    [ pos1[0] + pos2[0],
      pos1[1] + pos2[1] ]
  end

  def out_of_bounds?(pos)
    (pos[0] < 0 || pos[0] > 7 || pos[1] < 0 || pos[1] > 7)
  end

end

class SlidingPiece < Piece
  #The SlidingPiece class can implement #moves,
  #but it needs to know what directions a piece
  #can move in (diagonal, horizontally/vertically, both).
  #SlidingPiece#moves calls it's subclasses' #move_dirs method
  def moves
    #returns all move regardless of board boundaries
    valid_pos = []


    # move in each direction until hit a next piece
    self.move_dirs.each do |diff|
      current_pos = self.pos

      # ||
      # out of board boundaries
      until out_of_bounds?( current_pos )
        new_pos = get_new_pos(current_pos, diff)

        # KIND OF REDUNDANT WITH UNTIL; CHECK BACK LATER
        if out_of_bounds( new_pos )
          break
        # look if there is a piece there
        elsif self.board.empty?( new_pos )
          valid_pos << new_pos
        else  # board[pos] is not empty
          piece_at_pos = self.board.at( new_pos )
          if piece_at_pos.color != self.color
            valid_pos << new_pos
          end

          # Since found piece, need to break out of until loop
          break
        end

        current_pos = new_pos
      end
    end
    valid_pos
  end

end

class Bishop < SlidingPiece

  #each SlidingPiece subclass (B,R,Q)
  #will use move_dirs in it's move method
  def move_dirs
    [
      [1,   1],
      [1,  -1],
      [-1,  1],
      [-1, -1]
    ]
  end
end

class Rook < SlidingPiece

  #each SlidingPiece subclass (B,R,Q)
  #will use move_dirs in it's move method
  def move_dirs
    [
      [1,  0],  [0,  1],
      [-1, 0],  [0, -1]
    ]
  end
end

#QUEEN CAN DO WHAT BISHOP + ROOK CAN DO
class Queen < SlidingPiece

  #each SlidingPiece subclass (B,R,Q)
  #will use move_dirs in it's move method
  def move_dirs
    [
      [1,   1],
      [1,  -1],
      [-1,  1],
      [-1, -1],
      [ 1,  0],
      [-1,  0],
      [ 0,  1],
      [ 0, -1]
    ]
  end
end

class SteppingPiece < Piece

  def moves
    valid_pos = self.diffs.map do |diff|
      current_pos = self.pos

      new_pos = get_new_pos(current_pos, diff)

      # KIND OF REDUNDANT WITH UNTIL; CHECK BACK LATER
      unless out_of_bounds(new_pos)
        if self.board.empty?(new_pos)
          return new_pos
        else  # board[pos] is not empty
          piece_at_pos = self.board.at(new_pos)
          if piece_at_pos.color != self.color && !piece_at_pos.is_a?(King) # King can't be adjacent to King
            return new_pos
          end
        end
      end
      nil
    end
    valid_pos.select! { |pos| !pos.nil? }
  end

  def get_diffs
  end
end

class King < SteppingPiece

  def get_diffs
    [
    [1,   1],
    [1,  -1],
    [-1,  1],
    [-1, -1],
    [ 1,  0],
    [-1,  0],
    [ 0,  1],
    [ 0, -1]
           ]
  end
end

class Knight < SteppingPiece

  def get_diffs
    [
    [2,    1],
    [2,   -1],
    [1,    2],
    [1,   -2],
    [-1,   2],
    [-1,  -2],
    [-2,   1],
    [-2,  -1]
            ]
  end
end

#DO THIS LAST CUZ NED SED SO
class Pawn < Piece

end

class Board
  attr_accessor :grid#contains Piece or nil if no Piece

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