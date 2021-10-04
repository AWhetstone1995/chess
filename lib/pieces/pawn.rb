require_relative 'piece'

class Pawn < Piece
  def initialize(color, location)
    super(color, location)
    @icon = color == 'white' ? "\u265f" : "\u2659"
    @moved = false
  end

  # def possible_moves(board)
    # binding.pry
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
    unless @moved
      if @color == 'black'
        [
          [2, 0], [1, 0]
        ]
      else
        [
          [-2, 0], [-1, 0]
        ]
      end
    else
      if @color == 'black'
        [
          [1, 0]
        ]
      else
        [
          [-1, 0]
        ]
      end
    end
  end
end