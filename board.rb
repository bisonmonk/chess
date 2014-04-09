require "piece.rb"
require "pawn.rb"
require "sliding_piece.rb"
require "stepping_piece.rb"

# Board.rb

#  * a b c d e f g h  *
#  -------------------
#8 | r k b K Q b k r | 8
#7 | p p p p p p p p | 7
#6 | - - - - - - - - | 6
#5 | - - - - - - - - | 5
#4 | - - - - - - - - | 4
#3 | - - - - - - - - | 3
#2 | p p p p p p p p | 2
#1 | r k b K Q b k r | 1
#  -------------------
#  * a b c d e f g h  *

class Board
  attr_accessor :grid#contains Piece or nil if no Piece

  def initialize(setup)
    @grid = Array.new(8) { Array.new(8, nil)}

    if setup
      setup_pieces
    end
  end

  def setup_pieces

    #black
    self.at([0,0]) =   Rook.new([0,0], self, :black)
    self.at([0,1]) = Knight.new([0,1], self, :black)
    self.at([0,2]) = Bishop.new([0,2], self, :black)
    self.at([0,3]) =   King.new([0,3], self, :black)

    self.at([0,4]) =  Queen.new([0,4], self, :black)
    self.at([0,5]) = Bishop.new([0,5], self, :black)
    self.at([0,6]) = Knight.new([0,6], self, :black)
    self.at([0,7]) =   Rook.new([0,7], self, :black)


    #white
    self.at([7,0]) =   Rook.new([7,0], self, :white)
    self.at([7,1]) = Knight.new([7,1], self, :white)
    self.at([7,2]) = Bishop.new([7,2], self, :white)
    self.at([7,3]) =   King.new([7,3], self, :white)

    self.at([7,4]) =  Queen.new([7,4], self, :white)
    self.at([7,5]) = Bishop.new([7,5], self, :white)
    self.at([7,6]) = Knight.new([7,6], self, :white)
    self.at([7,7]) =   Rook.new([7,7], self, :white)

    #pawns
    (0..7).to_a.each do |ind|
      self.at([6,ind]) = Pawn.new([6,ind], self, :white)
      self.at([1,ind]) = Pawn.new([1,ind], self, :black)
    end

  end

  def checkmate?(color)
    if in_check?(color)
      all_pieces_valid_moves = []

      pieces_by_color(color).each do |piece|
        all_pieces_valid_moves += piece.valid_moves
      end

      all_pieces_valid_moves.empty?
    end
  end



    # None of piece


  #Returns whether a player is in check
  def in_check?(color)
    king_pos = king_by_color(color).pos
    #find the position of the king on the board then,

    opposing_pieces = pieces_by_color(opposing_color(color))
    #see if any of the opposing pieces can move to that
    #position
    opposing_pieces.each do |opp_piece|
      if opp_piece.moves.include?(king_pos)
        return true
      end
    end
    false
  end

  def opposing_color(color)
    if color == :white
      :black
    else
      :white
    end
  end

  def king_by_color(color)
    pieces.select { |piece| piece.is_a?(King) && piece.color == color }
  end

  def pieces_by_color(color)
    pieces.select { |piece| piece.color == color }
  end

  def pieces
    return @grid.flatten.compact
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

  def move_piece(from, to)
    piece = self.at(from)
    self.at(to) = piece

    piece.pos = to
    self.at(from) = nil

    # Handle Pawn first-move case
    if piece.is_a?(Pawn) && piece.first_move
      piece.first_move = false
    end
  end


  #updates the 2d grid and also the moved piece's
  #position

  #Raises exception if no piece at start
  # ||
  #piece cannot move to end_pos

  #Board#move should raise an exception if it would leave you in check.
  def move(start, end_pos)

    #NEED TO HANDLE EXCEPTION IN THE GAME CLASS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    if self.empty?(start)
      #MAYBE MAKE THIS IT'S OWN EXCEPTION
      raise "No piece at start location."
    elsif !self.at(start).moves.include?(end_pos)
      raise "Piece cannot move to end_pos."
    elsif !self.at(start).valid_moves.include?(end_pos)
      raise "You cannot move into CHECK!"
    else
      move_piece(start, end_pos)
    end
  end

  ##valid_moves needs to make a move on the duped board to see
  #if a player is left in check.
  #Method Board#move! makes a move without checking if it is valid.
  def move!(start, end_pos)
    move_piece(start, end_pos)
  end

  #should duplicate not only the Board, but
  #the pieces on the Board
  #Ruby's #dup method does not call dup on the instance variables,
  #so you may need to write your own Board#dup method
  #that will dup the individual pieces as well.
  def dup
    #after duplicating board,
    new_board = Board.new(false)

    # Get all old board pieces
    all_pieces = self.pieces

    # For each piece, create new piece with old piece's stuff and new board as B
    all_pieces.each do |piece|
      new_board.at( piece.pos ) = piece.dup(new_board)
    end

    new_board
  end
end


