require_relative 'piece'

class King < Piece
  def initialize(color, location)
    super(color, location)
    @icon = color == 'white' ? "\u265a" : "\u2654"
  end

  def find_moves(board)
    @possible_moves = []
    moves.each do |move|
      x = @location[0] + move[0]
      y = @location[1] + move[1]

      if x.between?(0, 7) && y.between?(0, 7)
        @possible_moves << [x, y] if board[x][y].nil? || board[x][y].color != @color
      end
    end
    @possible_moves
  end

  private

  def moves
    [
      [1, 1], [1, -1], [1, -1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]
    ]
  end
end
