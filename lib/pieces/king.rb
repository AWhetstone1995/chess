require_relative 'piece'
require 'pry-byebug'

class King < Piece
  def initialize(board, color, location)
    super(board, color, location)
    @icon = color == 'white' ? "\u265a" : "\u2654"
    @attackers = []
  end

  def find_moves
    @possible_moves = []
    moves.each do |move|
      x = @location[0] + move[0]
      y = @location[1] + move[1]
      destination_attacked = destination_in_check?([x, y])
      if x.between?(0, 7) && y.between?(0, 7)
        @possible_moves << [x, y] if (@board.data[x][y].nil? || @board.data[x][y].color != @color) && 
                                     !destination_attacked
      end
    end
    @possible_moves
  end

  def destination_in_check?(location)
    @board.data.flatten.each do |piece|
      next if piece.nil? || piece.color == @color || piece.is_a?(King)
      return true if piece.find_moves.include?(location)
    end
    false
  end

  # def other_piece_put_me_in_check?(piece, destination)
  #   binding.pry
  #   test_board = @board
  #   test_board.move_piece(piece.location, destination)
  #   test_board.data.flatten.each do |attacker|
  #     next if attacker.nil? || attacker.color == @color || attacker.is_a?(King)
  #     return true if attacker.find_moves.include?(@location)
  #   end
  #   false
  # end

  def attackers
    @attackers = []
    @board.data.flatten.each do |piece|
      next if piece.nil? || piece.color == @color || piece.is_a?(King)

      @attackers << piece if piece.find_moves.include?(@location)
    end
  end

  def in_check?
    return true if @attackers.size.positive?

    false
  end

  def checkmate?
    find_moves
    if @possible_moves.size.zero?
      attackers
      if @attackers.size.positive?
        @board.data.flatten.each do |piece|
          next if piece.nil? || piece.color != @color || piece.is_a?(King)
          next if piece.find_moves.include?(attackers_locations)
          return true if no_blocker
        end
      end
    end
    false
  end

  def no_blocker
    @attackers.each do |attacker|
      @board.data.flatten.each do |defender|
        next if defender.nil? || defender.color != @color || defender.is_a?(King)
        return false if defender.can_block?(defender, attacker)
      end
    end
    true
  end

  def attackers_locations
    locations = []
    @attackers.each do |piece|
      locations << piece.location
    end
    locations
  end

  private

  def moves
    [
      [1, 1], [1, -1], [-1, 1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]
    ]
  end
end