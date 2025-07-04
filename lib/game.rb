require_relative "board"
require_relative "module"
require_relative "player"
require "colorize"

class Game # rubocop:disable Style/Documentation
  include Coordinates
  def initialize(player = Player.new, board = Board.new)
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

  def play_game # rubocop:disable Metrics/MethodLength
    displays_the_board_before_the_game_begins
    chip_color = nil
    winning_horizontal_coords
    loop do
      user_input = @player1.make_move
      chip_color = :red
      break if user_input == "exit"

      register_move(user_input, chip_color)
      break if check_winner?(user_input, chip_color)

      user_input = @player2.make_move
      chip_color = :green
      break if user_input == "exit"

      register_move(user_input, chip_color)
      break if check_winner?(user_input, chip_color)
    end
  end

  def check_winner?(player_input, color)
    return true if check_correct_chip_placement?(player_input, color) # rubocop:disable Style/RedundantReturn
  end

  private

  def fills_the_board_with_hollow_circle_once
    @board.set_the_board if @board.hollow_circle.all?(nil)
  end

  def displays_the_board_with_hollow_circle_once
    return unless @board.hollow_circle.all?("\u25EF")

    @board.print_board
  end

  def displays_the_board_before_the_game_begins
    fills_the_board_with_hollow_circle_once
    displays_the_board_with_hollow_circle_once
  end

  def winning_horizontal_coords # rubocop:disable Metrics/MethodLength
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
end
