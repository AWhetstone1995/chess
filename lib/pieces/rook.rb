require_relative 'piece'

class Rook < Piece
  attr_reader :move_list
  def initialize(color, location)
    super(color, location)
    @icon = color == 'white' ? "\u265c" : "\u2656"
    @moved = false
    # @move_list = []
  end

  # def possible_moves(board)
  #   moves.each do |move|
  #     x = @location[0] + move[0]
  #     y = @location[1] + move[1]
  #     if x.between?(0, 7) && y.between?(0, 7)
  #       @possible_moves << [x, y] if board[x][y].nil? || board[x][y].color != @color
  #     end
  #   end
  # end

  private

  def moves
    [
      [0, 1], [0, -1], [1, 0], [-1, 0]
    ]
  end
end