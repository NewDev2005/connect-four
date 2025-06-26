require_relative "board"
require_relative "module"
require_relative "player"
require "colorize"

class Game # rubocop:disable Style/Documentation
  include Coordinates

  def initialize
    @coordinates = set_coordinates
    @player = Player.new
    @board = Board.new
  end

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

  def register_move
    user_input = @player.make_move
    @coordinates.each do |key, value|
      @board.hollow_circle[value] = "\u25CF".colorize(:red) if user_input == key
    end
    @board.print_board
  end
end


# obj = Game.new 
# obj.register_move
# obj.register_move