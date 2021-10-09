require_relative 'piece'

class Knight < Piece
  def initialize(board, color, location)
    super(board, color, location)
    @icon = color == 'white' ? "\u265e" : "\u2658"
    @moved = false
    # @move_list = possible_moves(board)
  end

  # Determine the possible moves of the knight object based on it's location on the board
  def find_moves
    # binding.pry
    @possible_moves = []
    moves.each do |move|
      x = @location[0] + move[0]
      y = @location[1] + move[1]
      if x.between?(0, 7) && y.between?(0, 7)
        @possible_moves << [x, y] if (@board.data[x][y].nil? || @board.data[x][y].color != @color)
      end
    end
    # binding.pry
    @possible_moves
  end

  private

  def moves
    [[-1, 2], [1, 2], [-1, -2], [1, -2], [-2, 1], [2, 1], [-2, -1], [2, -1]]
  end
end