require 'pry-byebug'

data = File.open('input.txt').read.split("\n")

VALID_HIKES = []

class Hike
  def initialize(map, x, y, steps = [])
    @map = map
    @steps = steps
    stroll(x, y)
  end

  def stroll(x, y)
    if y == @map.size - 1
      p VALID_HIKES.size
      return VALID_HIKES << @steps
    end

    @steps << [x, y]

    next_steps = []
    # next_steps << [x - 1, y] if x > 1 && %w[. <].include?(@map[y][x - 1]) && !@steps.include?([x - 1, y])
    # next_steps << [x + 1, y] if x + 2 < @map[0].size && %w[. >].include?(@map[y][x + 1]) && !@steps.include?([x + 1, y])
    # next_steps << [x, y - 1] if y > 1 && %w[. ^].include?(@map[y - 1][x]) && !@steps.include?([x, y - 1])
    # next_steps << [x, y + 1] if y + 1 < @map.size && %w[. v].include?(@map[y + 1][x]) && !@steps.include?([x, y + 1])
    next_steps << [x - 1, y] if x > 1 && (@map[y][x - 1]) != '#' && !@steps.include?([x - 1, y])
    next_steps << [x + 1, y] if x + 2 < @map[0].size && (@map[y][x + 1]) != '#' && !@steps.include?([x + 1, y])
    next_steps << [x, y - 1] if y > 1 && (@map[y - 1][x]) != '#' && !@steps.include?([x, y - 1])
    next_steps << [x, y + 1] if y + 1 < @map.size && (@map[y + 1][x]) != '#' && !@steps.include?([x, y + 1])
    return if next_steps.empty?

    if next_steps.size > 1
      next_steps[1..].each do |step|
        x, y = step
        Hike.new(@map, x, y, @steps.clone)
      end
    end
    xn, yn = next_steps.first
    stroll(xn, yn)
  end
end

def find_longest_path(source)
  VALID_HIKES.size.times { VALID_HIKES.delete_at(0) }
  Hike.new(source, 1, 0)
  # VALID_HIKES.sort_by { |hike| hike.size }.last.each_with_index do |coord, index|
  #   x, y = coord
  #   source[y][x] = (index % 10).to_s
  # end
  # pp source
  VALID_HIKES.max_by(&:size).each_with_index do |coord, index|
    x, y = coord
    source[y][x] = (index % 10).to_s
  end
  pp source
  VALID_HIKES.map(&:size).max
end

p find_longest_path(data)
