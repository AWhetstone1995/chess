require_relative 'board'
require_relative 'pieces/piece'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @current_player = 'white'
    @current_moves = []
  end

  def play
    until game_over?(@current_player)
      board.display_board
      print_king_in_check(@current_player)
      human_turn
    end
  end

  def human_turn
    puts "#{@current_player.capitalize}, please choose a piece you'd like to move. Select the column first and then the row. E.G A1."
    selection = check_legality(player_selection)
    move = choose_move
    while puts_king_in_check?(selection, move, @current_player)
      move = choose_move
    end
    board.move_piece(selection, move)
    @current_moves = []
    switch_current_player
  end

  def check_legality(input)
    input = translate_input(input)
    build_legal_moves(input)
    while @current_moves.empty?
      puts 'That piece does not have a valid move. Please pick another piece'
      input = translate_input(player_selection)
      build_legal_moves(input)
    end
    input
  end

  def choose_move
    puts "These are the legal moves you can make \n\n"
    print_legal_moves
    move = translate_input(player_move)
    until @current_moves.include?(move)
      puts "Please choose from these legal moves. \n\n"
      print_legal_moves
      move = translate_input(player_move)
    end
    move
  end

  def print_legal_moves
    print_arr = translate_for_player(@current_moves)
    print_arr.each do |index|
      print "     #{index.upcase} "
    end
    puts "\n\n"
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
    input = gets.chomp.downcase
    until validate_player_input(input) && correct_color_piece?(input)
      puts 'Please input a valid row and column of your color piece.'
      input = gets.chomp.downcase
    end
    input
  end

  def player_move
    input = gets.chomp.downcase
    until validate_player_input(input)
      puts 'Please input a valid row and column of your legal moves.'
      input = gets.chomp.downcase
    end
    input
  end

  def validate_player_input(input)
    return true if input.match?(/^[a-h][1-8]$/)

    false
  end

  def correct_color_piece?(input)
    coordinates = translate_input(input)
    if board.data[coordinates[0]][coordinates[1]].nil?
      puts 'That tile is empty, choose a piece you own.'
      false
    elsif board.data[coordinates[0]][coordinates[1]].color == @current_player
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

  def build_legal_moves(coords)
    @current_moves = board.data[coords[0]][coords[1]].find_moves
  end

  def print_king_in_check(color)
    puts "#{@current_player.capitalize} is in check." if board.king_in_check?(color)
  end

  def puts_king_in_check?(current_location, move_to, color)
    board.possible_king_check?(current_location, move_to, color)
  end

  def game_over?(color)
    board.game_checkmate?(color)
  end
end