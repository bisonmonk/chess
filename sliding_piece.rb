# SlidingPiece.rb

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