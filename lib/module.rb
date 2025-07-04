module Coordinates # rubocop:disable Style/Documentation
  def coordinates
    coordinates = {}
    num = 0
    (0..5).each do |i|
      (0..6).each do |j|
        coordinates["#{i},#{j}"] = num
        num += 1
      end
    end
    coordinates
  end
end
