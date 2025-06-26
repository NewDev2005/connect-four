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
