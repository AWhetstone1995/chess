require_relative 'board'
require_relative 'pieces/piece'

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    # binding.pry
    @board.setup_board
  end

  def play
    board.display_board
    # @board.data.each { |cell| p cell }
    human_turn
  end

  def human_turn
    # binding.pry
    puts "Please choose a piece you'd like to move"
    selection = translate_input(gets.chomp)
    # binding.pry
    puts "Choose the tile you'd like to move this piece to"
    move_to = translate_input(gets.chomp)
    board.move_piece(selection, move_to)
    board.display_board
    # binding.pry
    puts "Please choose a piece you'd like to move"
    selection = translate_input(gets.chomp)
    puts "Choose the tile you'd like to move this piece to"
    move_to = translate_input(gets.chomp)
    binding.pry
    board.data[selection[0]][selection[1]].possible_moves(board.data)
  end

  def translate_input(player_input)
    return_array = []
    coords = player_input.split(//)
    return_array << translate_row(coords[1])
    return_array << translate_column(coords[0])
    return_array
  end

  def translate_row(number)
    8 - number.to_i
  end

  def translate_column(letter)
    letter.downcase.ord - 97
  end
end