require_relative 'pieces/piece'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'display'

class Board
  attr_accessor :data
  attr_reader :white_king, :black_king

  def initialize
    @data = Array.new(8) { Array.new(8) }
    setup_board
    @white_captures = []
    @black_captures = []
    @white_king = data[7][4]
    @black_king = data[0][4]
    @moves_without_capture = 0
  end

  # set up initial board state
  def setup_board
    initial_pawns('white', 6)
    initial_pawns('black', 1)
    initial_row('white', 7)
    initial_row('black', 0)
  end

  def move_piece(from_square, new_square)
    @moves_without_capture += 1
    capture?(new_square)
    data[new_square[0]][new_square[1]] = data[from_square[0]][from_square[1]]
    data[from_square[0]][from_square[1]] = nil
    data[new_square[0]][new_square[1]].location = new_square
    data[new_square[0]][new_square[1]].rank = 8 - new_square[0]
    data[new_square[0]][new_square[1]].moved = true
  end

  def initial_row(color, row)
    data[row][0] = Rook.new(self, color, [row, 0])
    data[row][1] = Knight.new(self, color, [row, 1])
    data[row][2] = Bishop.new(self, color, [row, 2])
    data[row][3] = Queen.new(self, color, [row, 3])
    data[row][4] = King.new(self, color, [row, 4])
    data[row][5] = Bishop.new(self, color, [row, 5])
    data[row][6] = Knight.new(self, color, [row, 6])
    data[row][7] = Rook.new(self, color, [row, 7])
  end

  def initial_pawns(color, row)
    0.upto(7) do |i|
      data[row][i] = Pawn.new(self, color, [row, i])
    end
  end

  def display_board(current_player_color)
    moves_until_draw
    display_captures(current_player_color)
    display_rows
    display_row_letters
  end

  def king_in_check?(color)
    temp_board = clone_board
    temp_king = nil
    color == 'white' ? temp_king = temp_board.white_king : temp_king = temp_board.black_king

    temp_king.attackers
    temp_king.in_check?
  end

  def possible_king_check?(current_location, move_to, color)
    # binding.pry
    temp_board = clone_board
    temp_board.move_piece(current_location, move_to)
    temp_king = nil
    color == 'white' ? temp_king = temp_board.white_king : temp_king = temp_board.black_king

    temp_king.attackers
    temp_king.in_check?
  end

  def game_over?(color)
    return true if game_checkmate?(color)
    return true if move_count_draw
  end

  def capture?(defender)
    return if data[defender[0]][defender[1]].nil?

    @moves_without_capture = 0
    if data[defender[0]][defender[1]].color == 'white'
      @black_captures << data[defender[0]][defender[1]]
    else
      @white_captures << data[defender[0]][defender[1]]
    end
  end

  def clone_board
    Marshal.load(Marshal.dump(self))
  end

  # def legal_moves(piece)
  #   legal_moves = []
  #   possibilities = piece.possible_moves(data)
  #   # valid_moves(possibilities, piece.color)
  #   valid_captures(possibilities, piece.color)
  # end

  # def valid_moves(possible_moves, piece)
  #   valid_moves
  #   if piece.type_of?(Knight)
  #     possible_moves
  #   end
  # end

  # def valid_captures(possible_moves, color)
  #   valid_captures = []
  #   possible_moves.each do |move|
  #     unless data[move[0]][move[1]].nil?
  #       valid_captures << move if data[move[0]][move[1]].color != color
  #     end
  #   end
  #   valid_captures
  # end

  private

  def moves_until_draw
    puts "\n\n   Moves until draw: #{50 - @moves_without_capture}"
  end

  def game_checkmate?(color)
    if color == 'white'
      @white_king.checkmate?
    else
      @black_king.checkmate?
    end
  end

  def move_count_draw
    @moves_without_capture == 50
  end

  def display_rows
    (1..7).each do |row|
      display_row(row)
    end
    display_row(8)
  end

  def display_captures(color)
    captures_display = []
    if color == 'white'
      @white_captures.each do |piece|
        captures_display << piece.class
      end
    else
      @black_captures.each do |piece|
        captures_display << piece.class
      end
    end
    puts "   Current player captures: #{captures_display} \n\n"
  end

  def display_row(number)
    square = number.even? ? 0 : 1
    print "#{9 - number} "
    @data[number - 1].each do |position|
      if position.nil?
        print square.even? ? '|   ' : "|#{'   '.bg_black}"
      else
        print square.even? ? "| #{position.icon} " : "|#{" #{position.icon} ".bg_black}"
      end
      square += 1
    end
    puts '|'
  end

  def display_row_letters
    puts "    a   b   c   d   e   f   g   h  \n\n"
  end
end

# test_board = Board.new
# test_board.setup_board
# test_board.display_rows
# # binding.pry
# test_board.move_piece([7, 1], [5, 2])
# test_board.display_rows
# test_board.move_piece([0, 1], [2, 2])
# test_board.display_rows
# test_board.each { |cell| p cell }