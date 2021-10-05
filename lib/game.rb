require_relative 'board'
require_relative 'pieces/piece'

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    @current_player = 'white'
    @board.setup_board
  end

  def play
    loop do
      board.display_board
      human_turn
      board.display_board
      human_turn
    end
  end

  def human_turn
    puts "Please choose a piece you'd like to move. Select the column first and then the row. E.G A1."
    selection = translate_input(player_selection)
    moves = board.data[selection[0]][selection[1]].find_moves(board.data)
    while moves.empty?
      puts 'That piece does not have a valid move. Please pick another piece'
      selection = translate_input(player_selection)
      moves = moves = board.data[selection[0]][selection[1]].find_moves(board.data)
    end
    legal_moves = translate_for_player(moves)
    puts "These are the legal moves you can make. \n\n"
    puts "#{legal_moves} \n\n"
    move_to = translate_input(player_move)
    until moves.include?(move_to)
      puts "Please choose from these legal moves. \n\n"
      p legal_moves
      move_to = translate_input(player_move)
    end
    board.move_piece(selection, move_to)
    switch_current_player
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

  def player_selection
    input = gets.chomp
    until validate_player_input(input) && correct_side_piece?(input)
      puts 'Please input a valid row and column of your color piece.'
      input = gets.chomp
    end
    input
  end

  def player_move
    input = gets.chomp
    until validate_player_input(input)
      puts 'Please input a valid row and column of your legal moves.'
      input = gets.chomp
    end
    input
  end

  def validate_player_input(input)
    return true if input.match?(/^[a-h][1-8]$/)

    false
  end

  def correct_side_piece?(input)
    coordinates = translate_input(input)
    if board.data[coordinates[0]][coordinates[1]].color == @current_player
      true
    else
      puts "That piece does not belong to you.\n\n"
      false
    end
  end

  def switch_current_player
    @current_player == 'white' ? @current_player = 'black' : @current_player = 'white'
  end

  def translate_for_player(move_arr)
    return_arr = []
    move_arr.each do |move|
      new_move = []
      num_to_letter = (move[1] + 97).chr.downcase
      new_num = 8 - move[0]
      chess_coord = num_to_letter + new_num.to_s
      new_move << chess_coord
      return_arr << new_move
    end
    return_arr.flatten
  end
end
