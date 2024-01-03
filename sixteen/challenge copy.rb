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
    # shine_forth
  end

  def shine_forth
    x_max = @mirror_grid[0].size
    y_max = @mirror_grid.size
    new_beams = []
    i = 0
    p "ERROR" if i > 99_998
    # p "I am a shining light beam at (#{@x}, #{@y}) heading #{@direction}!"
    while @x >= 0 && @y >= 0 && @x < x_max && @y < y_max && i < 100_000
      return new_beams if ALREADY_LAUNCHED["#{@x}, #{@y}, #{@direction}"]

      ALREADY_LAUNCHED["#{@x}, #{@y}, #{@direction}"] = true
      @energy_grid[@y][@x] = '#'
      case @mirror_grid[@y][@x]
      when '-'
        if @direction == 'n' || @direction == 's'
          new_beams << Lightbeam.new(@x, @y, 'e', @mirror_grid, @energy_grid)
          @direction = 'w'
        end
      when '|'
        if @direction == 'e' || @direction == 'w'
          new_beams << Lightbeam.new(@x, @y, 'n', @mirror_grid, @energy_grid)
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
      i += 1
    end
    new_beams
  end
end

def analyze(contraption)
  energy_grid = contraption.map { |row| row.gsub(/[^.]/, '.') }

  light = Lightbeam.new(0, 0, 'e', contraption, energy_grid)
  beam(light)
  pp energy_grid
  energy_grid.join.gsub('.', '').size
end

def beam(beam, array = [])
  new_lightbeams = beam.shine_forth
  new_array = array.concat(new_lightbeams)
  new_beam = new_array.shift
  p "ERROR: too many in queue" if new_array.size > 20_000
  return if new_array.size > 20_000
  beam(new_beam, new_array) if new_beam
end

p analyze(data)
