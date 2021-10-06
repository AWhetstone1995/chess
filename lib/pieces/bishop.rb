require_relative 'piece'

class Bishop < Piece
  def initialize(board, color, location)
    super(board, color, location)
    @icon = color == 'white' ? "\u265d" : "\u2657"
  end

  private

  def moves
    [
      [1, 1], [1, -1], [-1, 1], [-1, -1]
    ]
  end
end
 