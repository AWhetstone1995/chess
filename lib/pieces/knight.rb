require_relative 'piece'

class Knight < Piece
  def initialize(color, location)
    super(color, location)
    @icon = color == 'white' ? "\u265e" : "\u2658"
    @moved = false
    # @move_list = possible_moves(board)
  end

  # Determine the possible moves of the knight object based on it's location on the board
  def possible_moves(board)
    # binding.pry
    moves.each do |move|
      x = @location[0] + move[0]
      y = @location[1] + move[1]
      if x.between?(0, 7) && y.between?(0, 7)
        @possible_moves << [x, y] if board[x][y].nil? || board[x][y].color != @color
      end
    end
  end

  private

  def moves
    [[-1, 2], [1, 2], [-1, -2], [1, -2], [-2, 1], [2, 1], [-2, -1], [2, -1]]
  end
end
