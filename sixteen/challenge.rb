require 'pry-byebug'
data = File.open('input.txt').read.split("\n")
ALREADY_LAUNCHED = {}

class Lightbeam
  def initialize(x, y, direction, mirror_grid, energy_grid)
    @x = x
    @y = y
    @direction = direction
    @mirror_grid = mirror_grid
    @energy_grid = energy_grid
    shine_forth
  end

  def shine_forth
    x_max = @mirror_grid[0].size
    y_max = @mirror_grid.size

    # p "I am a shining light beam at (#{@x}, #{@y}) heading #{@direction}!"
    while @x >= 0 && @y >= 0 && @x < x_max && @y < y_max
      return if ALREADY_LAUNCHED["#{@x}, #{@y}, #{@direction}"]

      ALREADY_LAUNCHED["#{@x}, #{@y}, #{@direction}"] = true
      @energy_grid[@y][@x] = '#'
      case @mirror_grid[@y][@x]
      when '-'
        if @direction == 'n' || @direction == 's'
          Lightbeam.new(@x, @y, 'e', @mirror_grid, @energy_grid)
          @direction = 'w'
        end
      when '|'
        if @direction == 'e' || @direction == 'w'
          Lightbeam.new(@x, @y, 'n', @mirror_grid, @energy_grid)
          @direction = 's'
        end
      when '/'
        case @direction
        when 'n'
          @direction = 'e'
        when 'e'
          @direction = 'n'
        when 's'
          @direction = 'w'
        when 'w'
          @direction = 's'
        end
      when '\\'
        case @direction
        when 'n'
          @direction = 'w'
        when 'e'
          @direction = 's'
        when 's'
          @direction = 'e'
        when 'w'
          @direction = 'n'
        end
      end
      # p "(#{@x}, #{@y}) : #{@mirror_grid[@y][@x]}, heading: #{@direction}"
      case @direction
      when 'n'
        @y -= 1
      when 'e'
        @x += 1
      when 's'
        @y += 1
      when 'w'
        @x -= 1
      end
    end
  end
end

def analyze(contraption, x, y, direction)
  ALREADY_LAUNCHED.keys.each { |key| ALREADY_LAUNCHED[key] = nil }
  energy_grid = contraption.map { |row| row.gsub(/[^.]/, '.') }

  Lightbeam.new(x, y, direction, contraption, energy_grid)
  energy_grid.join.gsub('.', '').size
end

def optimize(contraption)
  maximum_energy = []
  max_y = contraption.size - 1
  max_x = contraption[0].size - 1

  contraption.each_with_index do |row, y|
    row.size.times do |x|
      maximum_energy << analyze(contraption, x, 0, 's') if y == 0
      maximum_energy << analyze(contraption, x, y, 'n') if y == max_y
      maximum_energy << analyze(contraption, 0, y, 'e') if x == 0
      maximum_energy << analyze(contraption, x, y, 'w') if x == max_x
    end
  end

  maximum_energy.max
end

# p analyze(data, 0, 0, 'e')
p optimize(data)
