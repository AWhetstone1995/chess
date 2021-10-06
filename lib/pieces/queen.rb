require_relative 'piece'

class Queen < Piece
  def initialize(board, color, location)
    super(board, color, location)
    @icon = color == 'white' ? "\u265b" : "\u2655"
  end

  private

  def moves
    [
      [1, 1], [1, -1], [-1, 1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]
    ]
  end
end
