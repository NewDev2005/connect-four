# require_relative "../lib/board"
require_relative "../lib/game"
require_relative "spec_helper"

describe Board do
  subject(:board) { described_class.new }

  describe "#set_the_board" do
    it "checks all the elements of the @array has same value" do
      board.set_the_board
      arr = board.hollow_circle
      hollow_circle = "\u25EF"
      expect(arr).to all(eq(hollow_circle))
    end
  end
end

describe Game do # rubocop:disable Metrics/BlockLength
  subject(:game) { described_class.new }

  describe "#displays_the_board_before_the_game_begins" do
    it "displays the board with only hollow circles once before the game begins" do
      expect(game).to receive(:displays_the_board_before_the_game_begins).once
      game.displays_the_board_before_the_game_begins
    end
  end

  describe "#check_invalid_move" do # rubocop:disable Metrics/BlockLength
    context "when the user input is  a valid move" do
      before do
        valid_move = "0,1"
        allow(game).to receive(:gets).and_return(valid_move)
      end

      it "stops prompting for the user input and does not display the invalid error message" do
        valid_move = "0,1"
        error_message = "INVALID INPUT!>> re-enter a valid coord".colorize(:red)
        expect(game).not_to receive(:puts).with(error_message)
        game.check_invalid_move(valid_move)
      end
    end

    context "when the user enters a valid word called `exit` " do
      before do
        user_input = "exit"
        allow(game).to receive(:gets).and_return(user_input)
      end

      it "stops the loop and does not display the error message" do
        user_input = "exit"
        error_message = "INVALID INPUT!>> re-enter a valid coord".colorize(:red)
        expect(game).not_to receive(:puts).with(error_message)
        game.check_invalid_move(user_input)
      end
    end

    context "when the user enters an invalid move once and then a valid move" do
      before do
        valid_move = "1,0"
        allow(game).to receive(:gets).and_return(valid_move) # winning_horizontal_coords)
      end

      it "keeps prompting for the user input  and displays the error message once" do
        invalid_move = "15"
        error_message = "INVALID INPUT!>> re-enter a valid coord".colorize(:red)
        expect(game).to receive(:puts).with(error_message).once
        game.check_invalid_move(invalid_move)
      end
    end

    context "when the user enters an invalid move twice and then a valid move" do
      before do
        invalid_move = "10"
        valid_move = "0,2"
        allow(game).to receive(:gets).and_return(invalid_move, valid_move)
      end

      it "displays the error message two times" do
        invalid_move = "00"
        error_message = "INVALID INPUT!>> re-enter a valid coord".colorize(:red)
        expect(game).to receive(:puts).with(error_message).twice
        game.check_invalid_move(invalid_move)
      end
    end
  end

  describe "#register_move" do
    context "when the user enters a coordinate it register the player's move in that given coordinate" do
      it "fills the hollow circle with a red chip at the coordinate 0,2" do
        coord = "0,2"
        color = :red
        game.register_move(coord, color)
        board = game.instance_variable_get(:@board)
        expect(board.hollow_circle[2]).to eq("\u25CF".colorize(color))
      end
    end

    context "when given a valid coord followed by a color argument" do
      before do
        allow(game).to receive(:register_move).with("0,0", :green)
      end

      it "returns nil" do
        coord = "0,0"
        color = :green
        expect(game.register_move(coord, color)).to eql(nil)
        game.register_move(coord, color)
      end
    end
  end

  describe "#check_winner?" do # rubocop:disable Metrics/BlockLength
    context "when four chips of same color are placed vertically" do
      before do
        game.check_winner?("1,0", :red)
        game.check_winner?("2,0", :red)
        game.check_winner?("3,0", :red)
      end
      it "returns true" do
        expect(game.check_winner?("4,0", :red)).to eql(true)
      end
    end

    context "when four chips of the same color are placed horizontally" do
      before do
        game.check_winner?("0,0", :red)
        game.check_winner?("0,1", :red)
        game.check_winner?("0,2", :red)
      end
      it "returns true" do
        expect(game.check_winner?("0,3", :red)).to eql(true)
      end
    end

    context "when four chips of the same color are placed diagonally" do
      before do
        game.check_winner?("0,0", :red)
        game.check_winner?("1,1", :red)
        game.check_winner?("2,2", :red)
      end
      it "returns true" do
        expect(game.check_winner?("3,3", :red)).to eql(true)
      end
    end
  end
end
