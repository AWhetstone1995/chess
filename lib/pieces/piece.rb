require_relative '../board'

class Piece
  attr_accessor :location, :moved
  attr_reader :color, :icon

  def initialize(board, color, location)
    @board = board
    @color = color
    @location = location
    @possible_moves = []
    @moved = false
  end

  def find_moves
    @possible_moves = []
    king = nil
    if @color == 'white'
      king = @board.white_king
    else
      king = @board.black_king
    end
    moves.each do |move|
      x = @location[0] + move[0]
      y = @location[1] + move[1]

      loop do
        break unless x.between?(0, 7) && y.between?(0, 7)

        @possible_moves << [x, y] if (@board.data[x][y].nil? || @board.data[x][y].color != @color) &&
                                     !puts_king_in_check?([x, y], king)
        break unless @board.data[x][y].nil?

        x += move[0]
        y += move[1]
      end
    end
    @possible_moves
  end

  def can_block?(defender, attacker)
    # binding.pry
    attacker_moves = attacker.find_moves
    attacker_moves.each do |move|
      return true if defender.find_moves.include?(move)
    end
    false
  end

  def puts_king_in_check?(destination, king)
    king.other_piece_put_me_in_check?(self, destination)
  end
end