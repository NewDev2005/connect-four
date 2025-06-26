class Board
  attr_accessor :hollow_circle

  def initialize
    @hollow_circle = Array.new(42)
  end

  def set_the_board
    populate_the_board_with_hollow_circle
  end

  def print_board
    board
  end

  private

  def populate_the_board_with_hollow_circle
    (0..42).each do |i|
      @hollow_circle[i] = "\u25EF"
    end
  end

  def board # rubocop:disable Metrics/AbcSize
    puts "  \u250C\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2510"
    puts " 5\u2502#{@hollow_circle[35]} #{@hollow_circle[36]} #{@hollow_circle[37]} #{@hollow_circle[38]} #{@hollow_circle[39]} #{@hollow_circle[40]} #{@hollow_circle[41]}\u2502" # rubocop:disable Layout/LineLength
    puts " 4\u2502#{@hollow_circle[28]} #{@hollow_circle[29]} #{@hollow_circle[30]} #{@hollow_circle[31]} #{@hollow_circle[32]} #{@hollow_circle[32]} #{@hollow_circle[34]}\u2502" # rubocop:disable Layout/LineLength
    puts " 3\u2502#{@hollow_circle[21]} #{@hollow_circle[22]} #{@hollow_circle[23]} #{@hollow_circle[24]} #{@hollow_circle[25]} #{@hollow_circle[26]} #{@hollow_circle[27]}\u2502" # rubocop:disable Layout/LineLength
    puts " 2\u2502#{@hollow_circle[14]} #{@hollow_circle[15]} #{@hollow_circle[16]} #{@hollow_circle[17]} #{@hollow_circle[18]} #{@hollow_circle[19]} #{@hollow_circle[20]}\u2502" # rubocop:disable Layout/LineLength
    puts " 1\u2502#{@hollow_circle[7]} #{@hollow_circle[8]} #{@hollow_circle[9]} #{@hollow_circle[10]} #{@hollow_circle[11]} #{@hollow_circle[12]} #{@hollow_circle[13]}\u2502" # rubocop:disable Layout/LineLength
    puts " 0\u2502#{@hollow_circle[0]} #{@hollow_circle[1]} #{@hollow_circle[2]} #{@hollow_circle[3]} #{@hollow_circle[4]} #{@hollow_circle[5]} #{@hollow_circle[6]}\u2502" # rubocop:disable Layout/LineLength
    puts "  \u2514\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2518"
    puts "   0 1 2 3 4 5 6"
  end
end

# obj = Board.new
# obj.set_the_board
# obj.print_board