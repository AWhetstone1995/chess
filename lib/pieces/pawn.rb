require_relative 'piece'

class Pawn < Piece
  def initialize(board, color, location)
    super(board, color, location)
    @icon = color == 'white' ? "\u265f" : "\u2659"
  end

  def find_moves
    # binding.pry
    @possible_moves = []
    moves.each do |move|
      x = @location[0] + move[0]
      y = @location[1] + move[1]
      if x.between?(0, 7) && y.between?(0, 7)
        @possible_moves << [x, y] if @board.data[x][y].nil?
      end
    end
    legal_attacks
  end

  def legal_attacks
    attacks.each do |move|
      x = @location[0] + move[0]
      y = @location[1] + move[1]
      if x.between?(0, 7) && y.between?(0, 7)
        @possible_moves << [x, y] if !@board.data[x][y].nil? && @board.data[x][y].color != @color
      end
    end
    @possible_moves
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

  private

  def moves
    if !@moved
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

  def attacks
    if @color == 'black'
      [
        [1, -1], [1, 1]
      ]
    else
      [
        [-1, -1], [-1, 1]
      ]
    end
  end 
end