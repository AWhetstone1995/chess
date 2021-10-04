require_relative '../board'

class Piece
  attr_accessor :location, :moved
  attr_reader :color, :icon

  def initialize(color, location)
    # @board = board
    @color = color
    @location = location
    @possible_moves = []
    @moved = false
  end

  def find_moves(board)
    @possible_moves = []

    moves.each do |move|
      x = @location[0] + move[0]
      y = @location[1] + move[1]

      loop do
        break unless x.between?(0, 7) && y.between?(0, 7)

        @possible_moves << [x, y] if board[x][y].nil? || board[x][y].color != @color
        break unless board[x][y].nil?

        x += move[0]
        y += move[1]
      end
    end
    @possible_moves
  end
end