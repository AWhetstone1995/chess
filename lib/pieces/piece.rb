require_relative '../board'
require 'pry-byebug'

class Piece
  attr_accessor :location, :moved, :rank
  attr_reader :color, :icon

  def initialize(board, color, location)
    @board = board
    @color = color
    @location = location
    @possible_moves = []
    @moved = false
    @rank = 8 - location[0]
  end

  def find_moves
    # binding.pry
    @possible_moves = []
    moves.each do |move|
      x = @location[0] + move[0]
      y = @location[1] + move[1]
      loop do
        break unless x.between?(0, 7) && y.between?(0, 7)

        @possible_moves << [x, y] if @board.data[x][y].nil? || @board.data[x][y].color != @color
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

  # def puts_king_in_check?(destination)
  #   # binding.pry
  #   temp_board = @board.clone_board
  #   temp_board.move_piece(location, destination)
  #   check = false
  #   if @color == 'white' 
  #     check = temp_board.white_king.in_check?
  #   else
  #     check = temp_board.black_king.in_check?
  #   end
  #   check
  # end
end