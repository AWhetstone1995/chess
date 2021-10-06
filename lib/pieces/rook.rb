require_relative 'piece'

class Rook < Piece
  attr_reader :move_list
  def initialize(board, color, location)
    super(board, color, location)
    @icon = color == 'white' ? "\u265c" : "\u2656"
  end

  private

  def moves
    [
      [0, 1], [0, -1], [1, 0], [-1, 0]
    ]
  end
end