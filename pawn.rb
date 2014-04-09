load "stepping_piece.rb"
# Pawn.rb

#DO THIS LAST CUZ NED SED SO
class Pawn < SteppingPiece
  attr_accessor :first_move

  def initialize(pos, board, color)
    super(pos, board, color)
    @first_move = true
  end

  def get_diffs
    diffs = move_diffs

    if self.color == :black
      swap_colors(diffs)
    end
  end

  def move_diffs
    if get_valid_attack_diffs.empty?
      get_valid_attack_diffs #REFACTOR THIS SHIT!!!!!!!!!!!!!!!
    elsif self.first_move
      [
        [-2, 0],
        [-1, 0]
      ]
    else
      [
        [-1, 0]
      ]
      #move_diffs
    end
  end

  def swap_colors(diffs)
    diffs.each do |diff|
      diff.map! { |coor| coor *= -1}
    end
  end

  def get_valid_attack_diffs
    valid_attack_diffs = []
    attack_diffs.each do |attack_diff|
      new_pos = get_new_pos(self.pos, attack_diff)
      if !self.board.empty?(new_pos)
        valid_attack_diffs << attack_diff
      end
    end
    valid_attack_diffs
  end

  def attack_diffs
    if self.color == :black
      [
        [ 1,  1],
        [ 1, -1]
      ]
    else
      [
        [-1,  1],
        [-1, -1]
      ]
    end
  end

end