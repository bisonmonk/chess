# Piece.rb

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

    raise "Cannot implement moves for a general Piece"
    #should return an array of place this piece can move to
  end

  #Write Board#dup before writing this method!!!!!!!!!!
  #Board#move calls this method therefore valid_moves MUST NOT CALL Board#move!!!
  def valid_moves#playable_moves
    #filters out he #moves of a Piece that would leave the player in check
    # p "All moves in valid_moves: #{self.moves}"
    # self.moves.select { |move| p "Move in select is #{move}"; not move_into_check?(move) }
    self.moves.select { |move| not move_into_check?(move) }
  end

  #Filters out the #moves of a Piece that would leave
  #the player in check:
  def move_into_check?(pos)
    duped_board = self.board.dup
    duped_board.move!(self.pos, pos)
    duped_board.in_check?(self.color)
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
  def dup(new_board)
    #assign self.board to duped_board

    if self.class == Pawn
      new_pawn = self.class.new(self.pos, new_board, self.color, self.first_move)
    else
      self.class.new(self.pos, new_board, self.color)
    end

  end

  def get_new_pos(pos1, pos2)
    [ pos1[0] + pos2[0],
      pos1[1] + pos2[1] ]
  end

  def out_of_bounds?(pos)
    (pos[0] < 0 || pos[0] > 7 || pos[1] < 0 || pos[1] > 7)
  end

end