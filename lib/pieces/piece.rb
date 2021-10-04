require_relative '../board'

class Piece
  attr_accessor :location
  attr_reader :color, :icon, :board

  def initialize(color, location)
    # @board = board
    @color = color
    @location = location
    @possible_moves = []
  end
  
  def possible_moves(board)
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
  end
end