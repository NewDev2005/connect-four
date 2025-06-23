class Board
  attr_accessor :array

  def initialize
    @array = Array.new(42)
  end

  def set_the_board
    populate_the_board_with_hollow_circle
    board
  end

  def print_board
    board
  end

  private

  def populate_the_board_with_hollow_circle
    (0..42).each do |i|
      @array[i] = "\u25EF"
    end
  end

  def board
    puts "  \u250C\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2510"
    puts " 5\u2502#{array[35]} #{array[36]} #{array[37]} #{array[38]} #{array[39]} #{array[40]} #{array[41]}\u2502"
    puts " 4\u2502#{array[28]} #{array[29]} #{array[30]} #{array[31]} #{array[32]} #{array[32]} #{array[34]}\u2502"
    puts " 3\u2502#{array[21]} #{array[22]} #{array[23]} #{array[24]} #{array[25]} #{array[26]} #{array[27]}\u2502"
    puts " 2\u2502#{array[14]} #{array[15]} #{array[16]} #{array[17]} #{array[18]} #{array[19]} #{array[20]}\u2502"
    puts " 1\u2502#{array[7]} #{array[8]} #{array[9]} #{array[10]} #{array[11]} #{array[12]} #{array[13]}\u2502"
    puts " 0\u2502#{array[0]} #{array[1]} #{array[2]} #{array[3]} #{array[4]} #{array[5]} #{array[6]}\u2502"
    puts "  \u2514\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2518"
    puts "   0 1 2 3 4 5 6"
  end
end
