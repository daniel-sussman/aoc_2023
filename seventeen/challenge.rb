require 'pry-byebug'
require 'set'

data = File.open('input.txt').read.split("\n")

def fetch_path(graph)
  unvisited = Set.new
  tentative_distance = {}
  height = graph.size
  width = graph[0].size

  height.times do |y|
    width.times do |x|
      3.times do |i|
        4.times do |j|
          d = %w[n e s w][j]
          unvisited << [x, y, i, d]
          tentative_distance[[x, y, i, d]] = Float::INFINITY
        end
      end
    end
  end

  next_node = [0, 0, 0, 'w']
  tentative_distance[[0, 0, 0, 'w']] = 0

  until next_node[..1] == [width - 1, height - 1]
    current_node = unvisited.min_by { |node| tentative_distance[node] }
    x, y, _z, d = current_node
    next_node = d == 's' ? [x + 1, y, 0, 'e'] : [x, y + 1, 0, 's']
    i, j = next_node
    tentative_distance[next_node] = tentative_distance[current_node] + graph[j][i].to_i
    unvisited.delete(current_node)
    p j if i == j
  end
  tentative_solution = tentative_distance[next_node]

  tentative_distance[[0, 0, 0, 'n']] = 0

  until unvisited.empty?
    current_node = unvisited.min_by { |node| tentative_distance[node] }
    if tentative_distance[current_node] == Float::INFINITY
      break # remaining nodes have no connection with initial node
    elsif tentative_distance[current_node] > tentative_solution
      unvisited.delete(current_node)
      next # not worth investigating the rest
    elsif current_node[..1] == [width - 1, height - 1]
      tentative_solution = [tentative_distance[current_node], tentative_solution].min
    end

    unvisited_neighbors = neighbors(current_node, width, height).select { |neighbor| unvisited.include?(neighbor) }
    unvisited_neighbors.each do |unvisited_neighbor|
      x, y = unvisited_neighbor
      distance = tentative_distance[current_node] + graph[y][x].to_i
      tentative_distance[unvisited_neighbor] = [distance, tentative_distance[unvisited_neighbor]].min
    end
    unvisited.delete(current_node)
    p unvisited.size
  end
  pp tentative_distance
  p tentative_solution
end

def neighbors(node, width, height)
  x, y, z, dir = node
  result = []
  case dir
  when 'n'
    result << [x - 1, y, 0, 'w'] if x > 0
    result << [x + 1, y, 0, 'e'] if x + 1 < width
    result << [x, y - 1, z + 1, 'n'] if y > 0 && z < 2
    result << [x, y + 1, 0, 's'] if y + 1 < height
  when 'e'
    result << [x - 1, y, 0, 'w'] if x > 0
    result << [x + 1, y, z + 1, 'e'] if x + 1 < width && z < 2
    result << [x, y - 1, 0, 'n'] if y > 0
    result << [x, y + 1, 0, 's'] if y + 1 < height
  when 's'
    result << [x - 1, y, 0, 'w'] if x > 0
    result << [x + 1, y, 0, 'e'] if x + 1 < width
    result << [x, y - 1, 0, 'n'] if y > 0
    result << [x, y + 1, z + 1, 's'] if y + 1 < height && z < 2
  when 'w'
    result << [x - 1, y, z + 1, 'w'] if x > 0 && z < 2
    result << [x + 1, y, 0, 'e'] if x + 1 < width
    result << [x, y - 1, 0, 'n'] if y > 0
    result << [x, y + 1, 0, 's'] if y + 1 < height
  end
  result
end

fetch_path(data)


# class Path
#   def initialize(x, y, loss_map, min_energy_loss, history)
#     @x = x
#     @y = y
#     @min_energy_loss = min_energy_loss
#     @history = history
#     launch
#   end

#   def launch
#     @history << [@x, @y]

#   end
# end

# def find_best_path(source)
#   loss_map = source.map { |row| row.split('').map(&:to_i) }
#   min_loss_map = loss_map.map { |row| row.map { |e| 9999 } }
#   size = source.size - 1
#   y = size
#   x = size
#   min_loss = loss_map[y][x]
#   already_tried = []

#   queue = [[x - 1, y, 'e', 1], [x, y - 1, 's', 1]]
#   until queue.empty?
#     x, y, dir, blocks_before_turn = queue.shift
#     next p min_loss if x.zero? && y.zero?

#     next unless min_loss_map[y][x] > min_loss + loss_map[y][x]

#     already_tried << [x, y, dir, blocks_before_turn]
#     min_loss += loss_map[y][x]
#     min_loss_map[y][x] = min_loss

#     case dir
#     when 'e'
#       already_tried << [x + 1, y, 'w']
#       queue << [x - 1, y, 'e', blocks_before_turn + 1] if blocks_before_turn < 3 && x.positive? && (min_loss_map[y][x - 1] == -1 || min_loss_map[y][x - 1] > min_loss + loss_map[y][x - 1]) && !already_tried.include?([x - 1, y, 'e', blocks_before_turn + 1])
#       queue << [x, y - 1, 's', 1] if y.positive? && (min_loss_map[y - 1][x] == -1 || min_loss_map[y - 1][x] > min_loss + loss_map[y - 1][x]) && !already_tried.include?([x, y - 1, 's', 1])
#       queue << [x, y + 1, 'n', 1] if y < size && (min_loss_map[y + 1][x] == -1 || min_loss_map[y + 1][x] > min_loss + loss_map[y + 1][x]) && !already_tried.include?([x, y + 1, 'n', 1])
#     when 'w'
#       already_tried << [x - 1, y, 'e']
#       queue << [x + 1, y, 'w', blocks_before_turn + 1] if blocks_before_turn < 3 && x < size && (min_loss_map[y][x + 1] == -1 || min_loss_map[y][x + 1] > min_loss + loss_map[y][x + 1]) && !already_tried.include?([x + 1, y, 'w', blocks_before_turn + 1])
#       queue << [x, y - 1, 's', 1] if y.positive? && (min_loss_map[y - 1][x] == -1 || min_loss_map[y - 1][x] > min_loss + loss_map[y - 1][x]) && !already_tried.include?([x, y - 1, 's', 1])
#       queue << [x, y + 1, 'n', 1] if y < size && (min_loss_map[y + 1][x] == -1 || min_loss_map[y + 1][x] > min_loss + loss_map[y + 1][x]) && !already_tried.include?([x, y + 1, 'n', 1])
#     when 's'
#       already_tried << [x, y + 1, 'n']
#       queue << [x - 1, y, 'e', 1] if x.positive? && (min_loss_map[y][x - 1] == -1 || min_loss_map[y][x - 1] > min_loss + loss_map[y][x - 1]) && !already_tried.include?([x - 1, y, 'e', 1])
#       queue << [x + 1, y, 'w', 1] if x < size && (min_loss_map[y][x + 1] == -1 || min_loss_map[y][x + 1] > min_loss + loss_map[y][x + 1]) && !already_tried.include?([x + 1, y, 'w', 1])
#       queue << [x, y - 1, 's', blocks_before_turn + 1] if blocks_before_turn < 3 && y.positive? && (min_loss_map[y - 1][x] == -1 || min_loss_map[y - 1][x] > min_loss + loss_map[y - 1][x]) && !already_tried.include?([x, y - 1, 's', blocks_before_turn + 1])
#     when 'n'
#       already_tried << [x, y - 1, 's']
#       queue << [x - 1, y, 'e', 1] if x.positive? && (min_loss_map[y][x - 1] == -1 || min_loss_map[y][x - 1] > min_loss + loss_map[y][x - 1]) && !already_tried.include?([x - 1, y, 'e', 1])
#       queue << [x + 1, y, 'w', 1] if x < size && (min_loss_map[y][x + 1] == -1 || min_loss_map[y][x + 1] > min_loss + loss_map[y][x + 1]) && !already_tried.include?([x + 1, y, 'w', 1])
#       queue << [x, y + 1, 'n', blocks_before_turn + 1] if blocks_before_turn < 3 && y < size && (min_loss_map[y + 1][x] == -1 || min_loss_map[y + 1][x] > min_loss + loss_map[y + 1][x]) && !already_tried.include?([x, y + 1, 'n', blocks_before_turn + 1])
#     end
#     queue = queue.uniq
#   end
#   min_loss
# end


# $min_energy_loss = -1
# PATHS = {}
# OPPOSITES = {
#   'n' => 's',
#   'e' => 'w',
#   's' => 'n',
#   'w' => 'e'
# }

# class Probe
#   def initialize(y, x, direction, grid, tracking_grid = grid.map { |row| row.gsub(/./, '.') }, energy_loss = grid[-1][-1].to_i, blocks_since_turn = 1)
#     @y = y
#     @x = x
#     @direction = direction
#     @grid = grid
#     @tracking_grid = tracking_grid
#     @energy_loss = energy_loss
#     @blocks_since_turn = blocks_since_turn
#     p "New probe launched at (#{x}, #{y}) heading #{direction}"
#     launch
#   end

#   def launch
#     return if @y.negative? || @y == $size || @x.negative? || @x == $size

#     if @y.zero? && @x.zero?
#       $min_energy_loss = @energy_loss if @energy_loss < $min_energy_loss
#       pp @tracking_grid if @energy_loss < $min_energy_loss
#       return
#     end

#     return if @energy_loss >= $min_energy_loss
#     return if PATHS["#{@y},#{@x},#{OPPOSITES[@direction]}"] && PATHS["#{@y},#{@x},#{OPPOSITES[@direction]}"] < @energy_loss

#     PATHS["#{@y},#{@x},#{OPPOSITES[@direction]}"] = @energy_loss

#     @energy_loss += @grid[@y][@x].to_i

#     case @direction
#     when 'n'
#       @tracking_grid[@y + 1][@x] = 'v'
#       Probe.new(@y - 1, @x, 'n', @grid, @tracking_grid, @energy_loss, @blocks_since_turn + 1) if @blocks_since_turn < 3
#       Probe.new(@y, @x + 1, 'e', @grid, @tracking_grid, @energy_loss)
#       Probe.new(@y, @x - 1, 'w', @grid, @tracking_grid, @energy_loss)
#     when 'e'
#       @tracking_grid[@y][@x - 1] = '<'
#       Probe.new(@y, @x + 1, 'e', @grid, @tracking_grid, @energy_loss, @blocks_since_turn + 1) if @blocks_since_turn < 3
#       Probe.new(@y - 1, @x, 'n', @grid, @tracking_grid, @energy_loss)
#       Probe.new(@y + 1, @x, 's', @grid, @tracking_grid, @energy_loss)
#     when 's'
#       @tracking_grid[@y - 1][@x] = '^'
#       Probe.new(@y + 1, @x, 's', @grid, @tracking_grid, @energy_loss, @blocks_since_turn + 1) if @blocks_since_turn < 3
#       Probe.new(@y, @x + 1, 'e', @grid, @tracking_grid, @energy_loss)
#       Probe.new(@y, @x - 1, 'w', @grid, @tracking_grid, @energy_loss)
#     when 'w'
#       @tracking_grid[@y][@x + 1] = '>'
#       Probe.new(@y, @x - 1, 'w', @grid, @tracking_grid, @energy_loss, @blocks_since_turn + 1) if @blocks_since_turn < 3
#       Probe.new(@y - 1, @x, 'n', @grid, @tracking_grid, @energy_loss)
#       Probe.new(@y + 1, @x, 's', @grid, @tracking_grid, @energy_loss)
#     end
#   end
# end

# def navigate(map)
#   PATHS.keys.each { |key| PATHS[key] = nil }
#   $size = map.size
#   y = $size - 1
#   x = $size - 1

#   $min_energy_loss = initial_probe(y, x, map)
#   Probe.new(y, x - 1, 'w', map)
#   Probe.new(y - 1, x, 'n', map)
#   $min_energy_loss
# end

# def initial_probe(y, x, map)
#   result = 0
#   until y.zero? && x.zero?
#     x -= 1
#     result += map[y][x].to_i
#     y -= 1
#     result += map[y][x].to_i
#   end
#   result
# end

# p navigate(data)
# find_best_path(data)
