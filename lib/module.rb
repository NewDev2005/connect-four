module Coordinates
  # from the bottom of the board
  def first_row_coordinates
    coordinates = {}
    (0..6).each do |i|
      coordinates["0,#{i}"] = i
    end
    coordinates
  end

  def second_row_coordinates
    coordinates = {}
    num = 7
    (0..6).each do |i|
      coordinates["1,#{i}"] = num
      num += 1
    end
    coordinates
  end

  def third_row_coordinates
    coordinates = {}
    num = 14
    (0..6).each do |i|
      coordinates["2,#{i}"] = num
      num += 1
    end
    coordinates
  end

  def four_row_coordinates
    coordinates = {}
    num = 21
    (0..6).each do |i|
      coordinates["3,#{i}"] = num
      num += 1
    end
    coordinates
  end

  def five_row_coordinates
    coordinates = {}
    num = 28
    (0..6).each do |i|
      coordinates["4,#{i}"] = num
      num += 1
    end
    coordinates
  end

  def six_row_coordinates
    coordinates = {}
    num = 35
    (0..6).each do |i|
      coordinates["5,#{i}"] = num
      num += 1
    end
    coordinates
  end

  def set_coordinates
    first_row_coordinates.merge(second_row_coordinates).merge(third_row_coordinates).merge(four_row_coordinates).merge(five_row_coordinates).merge(six_row_coordinates) # rubocop:disable Layout/LineLength
  end
end

