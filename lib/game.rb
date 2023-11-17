# one class, Game
class Game
  @@turn_count = 1
  @@winner = ''

 def initialize(player_one_name, player_two_name)
    @player_one_name = player_one_name
    @player_two_name = player_two_name
    @board = Array.new(3) { Array.new(3, '_') }
    @turn_count = 1
    @winner = ''
  end

  # blank board showing in console
  def display_board(board)
    puts "\r"
    puts  "#{board[0][0]} | #{board[0][1]} | #{board[0][2]}"
    puts  "#{board[1][0]} | #{board[1][1]} | #{board[1][2]}"
    puts  "#{board[2][0]} | #{board[2][1]} | #{board[2][2]}"
    puts "\r"
  end

  def player_turn(turn)
    if turn.odd?
      puts "#{@player_one_name}'s turn (O)"
      player_choice(@player_one_name, 'O')
    else
      puts "#{@player_two_name}'s turn (X)"
      player_choice(@player_two_name, 'X')
    end
  end

 def player_choice(player, symbol)
  puts "#{player} please enter your coordinates (0..2) separated by a space"
  user_input = gets.chomp
  input_array = user_input.split
  coord_one = input_array[0].to_i
  coord_two = input_array[1].to_i

    # loop until the user input is valid - has space, between 0 and two, board slot is free
    until user_input.match(/\s/) && coord_one.between?(0, 2) && coord_two.between?(0, 2) && @board[coord_one][coord_two] == '_'
      puts 'Please enter valid coordinates for an empty space in the grid'
      user_input = gets.chomp
      input_array = user_input.split
      coord_one = input_array[0].to_i
      coord_two = input_array[1].to_i
    end

    add_to_board(coord_one, coord_two, symbol)
  end

  def add_to_board(coord_one, coord_two, symbol)
    @board[coord_one][coord_two] = symbol
    @@turn_count += 1
  end

def check_winner
  return true if three_across || three_down || three_diagonal
  false
end

  def three_across
  @board.each do |i|
    if i.all? { |j| j == 'X' }
      return true
    elsif i.all? { |j| j == 'O' }
      return true
    end
  end
  false
end

  # check 3 down
  def three_down
  flat = @board.flatten
  (0..2).each do |i|
    if flat[i] == 'X' && flat[i + 3] == 'X' && flat[i + 6] == 'X'
      return true
    elsif flat[i] == 'O' && flat[i + 3] == 'O' && flat[i + 6] == 'O'
      return true
    end
  end
  false
end

  # check diagonal
  def three_diagonal
  center_val = @board[1][1]
  if %w[X O].include?(center_val)
    if @board[0][0] == center_val && @board[2][2] == center_val
      return true
    elsif @board[2][0] == center_val && @board[0][2] == center_val
      return true
    end
  end
  false
end

  def declare_result(symbol)
    case symbol
    when 'O'
      puts "#{@player_one_name} wins the game!"
    when 'X'
      puts "#{@player_two_name} wins the game!"
    else
      puts "It's a tie!"
    end
  end

    def play_game
    puts "\r\n"
    puts 'Here is your empty battlefield!'
    puts "\r\n"
    display_board(@board)
    puts "\r\n"

    until @turn_count >= 10 || @winner != ''
      player_turn(@turn_count)
      display_board(@board)
      break if check_winner
    end

    declare_result(@winner)
  end
end

# instructions
puts 'Welcome to tic-tac-toe. The rules are as expected, but choosing placement requires coordinates.'
puts 'Each turn, enter two numbers with a space, per the grid layout below:'
puts "\r\n"
puts '0 0 | 0 1 | 0 2'
puts '1 0 | 1 1 | 1 2'
puts '2 0 | 2 1 | 2 2'
puts "\r\n"

# instantiate Game and execute play game
puts 'Player 1 - enter your name!'
player_one_name = gets.chomp
puts 'Player 2 - enter your name!'
player_two_name = gets.chomp

game = Game.new(player_one_name, player_two_name)
game.play_game