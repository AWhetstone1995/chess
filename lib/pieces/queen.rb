require_relative 'piece'

class Queen < Piece
  def initialize(color, location)
    super(color, location)
    @icon = color == 'white' ? "\u265b" : "\u2655"
  end

  # def possible_moves(board)
  #   moves.each do |move|
  #     x = @location[0] + move[0]
  #     y = @location[1] + move[1]
  #     if x.between?(0, 7) && y.between?(0, 7)
  #       result << [x, y] if board[x][y].nil? || board[x][y].color != @color
  #     end
  #   end
  #   result
  # end

  private

  def moves
    [
      [1, 1], [1, -1], [1, -1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]
    ]
  end
end
