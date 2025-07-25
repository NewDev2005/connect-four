require_relative "board"
require_relative "module"
require_relative "player"
require "colorize"

class Game # rubocop:disable Style/Documentation,Metrics/ClassLength
  include Coordinates
  def initialize(player = Player.new, board = Board.new) # rubocop:disable Metrics/MethodLength
    @player1 = player
    @player2 = player
    @board = board
    @vertical_placement = [
      %w[0,0 1,0 2,0 3,0],
      %w[1,0 2,0 3,0 4,0],
      %w[2,0 3,0 4,0 5,0],
      %w[0,1 1,1 2,1 3,1],
      %w[1,1 2,1 3,1 4,1],
      %w[2,1 3,1 4,1 5,1],
      %w[0,2 1,2 2,2 3,2],
      %w[1,2 2,2 3,2 4,2],
      %w[2,2 3,2 4,2 5,2],
      %w[0,3 1,3 2,3 3,3],
      %w[1,3 2,3 3,3 4,3],
      %w[2,3 3,3 4,3 5,3],
      %w[0,4 1,4 2,4 3,4],
      %w[1,4 2,4 3,4 4,4],
      %w[2,4 3,4 4,4 5,4],
      %w[0,5 1,5 2,5 3,5],
      %w[1,5 2,5 3,5 4,5],
      %w[2,5 3,5 4,5 5,5],
      %w[0,6 1,6 2,6 3,6],
      %w[1,6 2,6 3,6 4,6],
      %w[2,6 3,6 4,6 5,6]
    ]
    @horizontal_placement = []
    @diagonal_placement = [
      %w[3,0 2,1 1,2 0,3],
      %w[4,0 3,1 2,2 1,3],
      %w[3,1 2,2 1,3 0,4],
      %w[5,0 4,1 3,2 2,3],
      %w[4,1 3,2 2,3 1,4],
      %w[3,2 2,3 1,4 0,5],
      %w[5,1 4,2 3,3 2,4],
      %w[4,2 3,3 2,4 1,5],
      %w[3,3 2,4 1,5 0,6],
      %w[5,2 4,3 3,4 2,5],
      %w[4,3 3,4 2,5 1,6],
      %w[5,3 4,4 3,5 2,6],
      %w[0,0 1,1 2,2 3,3],
      %w[1,1 2,2 3,3 4,4],
      %w[2,2 3,3 4,4 5,5],
      %w[0,1 1,2 2,3 3,4],
      %w[1,2 2,3 3,4 4,5],
      %w[2,3 3,4 4,5 5,6],
      %w[0,2 1,3 2,4 3,5],
      %w[1,3 2,4 3,5 4,6],
      %w[0,3 1,4 2,5 3,6],
      %w[1,0 2,1 3,2 3,4],
      %w[2,1 3,2 4,3 5,4],
      %w[2,0 3,1 4,2 5,3]
    ]
  end

  def register_move(user_input, color)
    coordinates.each do |key, value|
      @board.hollow_circle[value] = "\u25CF".colorize(color) if user_input == key
    end
    @board.print_board
  end

  def displays_the_board_before_the_game_begins
    fills_the_board_with_hollow_circle_once
    displays_the_board_with_hollow_circle_once
  end

  def check_invalid_move(player_input)
    until coordinates.key?(player_input) || player_input == "exit"
      puts "INVALID INPUT!>> re-enter a valid coord".colorize(:red)
      player_input = gets.chomp
    end
    player_input
  end

  def play_game # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    displays_the_board_before_the_game_begins
    chip_color = nil
    winning_horizontal_coords
    loop do
      print "\n"
      print ">>> "
      user_input = @player1.make_move
      chip_color = :red

      user_input = check_invalid_move(user_input)
      break if user_input == "exit"

      user_input = illegal_move(user_input)
      user_input = illegal_move2(user_input)

      register_move(user_input, chip_color)
      break if check_winner?(user_input, chip_color)

      print "\n"
      print ">>> "
      user_input = @player2.make_move
      chip_color = :green

      user_input = check_invalid_move(user_input)
      break if user_input == "exit"

      user_input = illegal_move(user_input)
      user_input = illegal_move2(user_input)


      register_move(user_input, chip_color)
      break if check_winner?(user_input, chip_color)
    end
  end

  private

  def fills_the_board_with_hollow_circle_once
    @board.set_the_board if @board.hollow_circle.all?(nil)
  end

  def displays_the_board_with_hollow_circle_once
    return unless @board.hollow_circle.all?("\u25EF")

    @board.print_board
  end

  def winning_horizontal_coords
    @vertical_placement.each do |sub_arr|
      arr = []
      sub_arr.each do |elem|
        reversed_str = elem.reverse
        arr.push(reversed_str)
      end
      @horizontal_placement.push(arr)
    end
  end

  def check_correct_chip_placement?(player_input, color) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/AbcSize,Metrics/PerceivedComplexity
    types_of_chip_placement = [@vertical_placement, @horizontal_placement, @diagonal_placement]

    types_of_chip_placement.each_with_index do |chip_placement, index1|
      break unless chip_placement.each_with_index do |sub_arr, index2|
        break unless sub_arr.each_with_index do |coord, index3|
          types_of_chip_placement[index1][index2][index3] = color if coord == player_input
        end
      end
    end

    types_of_chip_placement.each do |multi_dimen_arr|
      multi_dimen_arr.each do |sub_arr|
        return true if sub_arr.all?(:red) || sub_arr.all?(:green)
      end
    end
    false
  end

  def check_winner?(player_input, color)
    return true if check_correct_chip_placement?(player_input, color) # rubocop:disable Style/RedundantReturn
  end

  def check_input_is_equivalent_to_coord?(player_input)
    coordinates.each do |key, value|
      return true if player_input == key && @board.hollow_circle[value] != "\u25EF"
    end
    false
  end

  def check_if_chip_is_placed_above_another_chip?(player_input)
    str = player_input
    arr = str.split(",").map(&:to_i)
    arr[0] = arr[0] - 1
    coord = arr.map(&:to_s).join(",")
    coordinates.each do |key, value|
      return false if coord == key && @board.hollow_circle[value] == "\u25EF"
    end
    true
  end

  def illegal_move(player_input)
    until check_if_chip_is_placed_above_another_chip?(player_input)
      puts "Sorry but This not how this game works!".colorize(:red)
      player_input = gets.chomp
      player_input = invalid_move(player_input)
    end
    player_input
  end

  def illegal_move2(player_input)
    while check_input_is_equivalent_to_coord?(player_input)
      puts "A chip has been placed at #{player_input} already kindly try a different move!".colorize(:yellow)
      player_input = gets.chomp
    end
    player_input
  end
end
