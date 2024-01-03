require 'pry-byebug'

data = File.open('input.txt').read.split("\n")

POSITIONS = {}

class Brick
  attr_reader :cubes, :resting_on
  attr_accessor :supporting

  def initialize(a, b)
    @cubes = [a.clone]
    @n = nil
    3.times do |i|
      @n = i unless a[i] == b[i]
    end
    until a == b
      a[@n] += 1
      @cubes << a.clone
    end
    @supporting = []
    @resting_on = []
    settle
    @cubes.each { |cube| POSITIONS[cube.to_s] = self }
  end

  def settle
    x, y, z = @cubes.first
    while z > 1
      @cubes.each do |cube|
        x, y = cube
        if POSITIONS["[#{x}, #{y}, #{z - 1}]"]
          @resting_on << POSITIONS["[#{x}, #{y}, #{z - 1}]"]
        end
      end
      if @resting_on.empty?
        z -= 1
      else
        @resting_on = @resting_on.uniq
        @resting_on.each { |other_brick| other_brick.supporting << self }
        break
      end
    end
    @n == 2 ? @cubes.each_with_index { |cube, i| cube[2] = z + i } : @cubes.each { |cube| cube[2] = z }
  end
end

# class Brick
#   attr_reader :cubes, :resting_on
#   attr_accessor :supporting

#   def initialize(a, b)
#     @cubes = [a.clone]
#     @n = -1
#     3.times do |i|
#       @n = i unless a[i] == b[i]
#     end
#     until a == b
#       a[@n] += 1
#       @cubes << a.clone
#     end
#     @supporting = []
#     @resting_on = []
#   end

#   def settle(bricks)
#     settled = false
#     x, y, z = @cubes.first
#     bricks[z].delete(self)
#     while z > 1
#       bricks[z - 1].each do |other_brick|
#         case @n
#         when 0
#           if other_brick.cubes.any? { |other_cube| other_cube[1] == y && @cubes.map{ |cube| cube[0] }.include?(other_cube[0]) }
#             other_brick.supporting << self
#             @resting_on << other_brick
#             next settled = true
#           end
#         when 1
#           if other_brick.cubes.any? { |other_cube| other_cube[0] == x && @cubes.map{ |cube| cube[1] }.include?(other_cube[1]) }
#             other_brick.supporting << self
#             @resting_on << other_brick
#             next settled = true
#           end
#         else
#           if other_brick.cubes.any? { |other_cube| other_cube[0] == x && other_cube[1] == y }
#             other_brick.supporting << self
#             @resting_on << other_brick
#             next settled = true
#           end
#         end
#       end
#       break if settled

#       z -= 1
#     end
#     @n == 2 ? @cubes.each_with_index { |cube, i| cube[2] = z + i } : @cubes.each { |cube| cube[2] = z }
#     bricks[z] << self
#   end
# end

# def count_safe_bricks(source)
#   bricks = Hash.new { |hash, key| hash[key] = [] }
#   source.each do |brick|
#     a, b = brick.split('~').map{ |coords| coords.split(',').map(&:to_i) }
#     bricks[b[2]] << Brick.new(a, b)
#   end
#   bricks.keys.sort.each do |key|
#     bricks[key].each { |brick| brick.settle(bricks) }
#   end

#   safe_bricks_count = 0
#   bricks.values.flatten.each do |brick|
#     safe_bricks_count += 1 unless brick.supporting.size == 1
#   end
#   p safe_bricks_count
# end

def tally_safe_bricks(source)
  POSITIONS.keys.each { |key| POSITIONS[key] = nil }
  bricks = []
  source.sort_by! { |brick| brick.split('~').first.split(',').last }
  source.each do |brick|
    a, b = brick.split('~').map{ |coords| coords.split(',').map(&:to_i) }
    bricks << Brick.new(a, b)
    pp "#{bricks.last.cubes} : resting on: #{bricks.last.resting_on.map(&:cubes)}"
  end
  safe_bricks_count = 0
  bricks.each do |brick|
    # pp brick.cubes
    # pp "resting on: #{brick.resting_on.size}"
    # pp "supporting: #{brick.supporting.size}"

    if brick.supporting.empty? || brick.supporting.all? { |other_brick| other_brick.resting_on.size > 1 }
      safe_bricks_count += 1
    end
  end
  safe_bricks_count
end

p tally_safe_bricks(data)
