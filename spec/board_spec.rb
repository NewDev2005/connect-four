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

describe Game do
  subject(:game) { described_class.new }

  describe "#displays_the_board_before_the_game_begins" do

    it "displays the board with only hollow circles once before the game begins" do
      expect(game).to receive(:displays_the_board_before_the_game_begins).once
      game.displays_the_board_before_the_game_begins
    end
  end

  describe "#check_invalid_move" do

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

    context "when the user enters exit" do
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
        invalid_move = "15"
        allow(game).to receive(:gets).and_return(invalid_move)
      end

      it "keeps prompting for the user input  and displays the error message" do
        invalid_move = "15"
        error_message = "INVALID INPUT!>> re-enter a valid coord".colorize(:red)
        expect(game).to receive(:puts).with(error_message)
        game.check_invalid_move(invalid_move)
        # game.check_invalid_move(valid_move)
      end
    end
  end
end
