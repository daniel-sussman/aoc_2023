data = File.open('input.txt').read.split("\n")

def measure(dig_plan)
  instructions, grid, (x, y) = build_grid(dig_plan)

  instructions.each do |instruction|
    instruction[1].to_i.times do
      grid[y][x] = '#'
      case instruction[0]
      when 'L'
        x -= 1
      when 'R'
        x += 1
      when 'U'
        y -= 1
      when 'D'
        y += 1
      end
    end
  end
  pp grid
  measure_area(grid)
end

def shoelace(dig_plan)
  #result (ccw) - (xmax - 1) - ymax
  x0 = 0
  y0 = 0
  sum_vertices = dig_plan.inject(0) do |sum, vertex|
    elements = vertex.split[2].match(/\(#(\w{5})(\w)\)/)
    side_length = elements[1].to_i(16) + 1
    case elements[2]
    when '2'
      x1 = x0 - side_length
      y1 = y0
    when '0'
      x1 = x0 + side_length
      y1 = y0
    when '3'
      x1 = x0
      y1 = y0 - side_length
    when '1'
      x1 = x0
      y1 = y0 + side_length
    end

    result = (x0 * y1) - (x1 * y0)
    x0 = x1
    y0 = y1
    sum + result
  end
  sum_vertices / 2
end

def build_sides(dig_plan)
  x0 = 0
  y0 = 0
  vertices = []
  sum_vertices = dig_plan.each.with_index.inject(0) do |sum, (instruction, i)|
    elements = instruction.split[2].match(/\(#(\w{5})(\w)\)/)
    a = dig_plan[i - 1].split[2].match(/\(#\w{5}(\w)\)/)[1]
    b = dig_plan[(i == dig_plan.size - 1 ? 0 : i + 1)].split[2].match(/\(#\w{5}(\w)\)/)[1]
    side_length = a == b ? elements[1].to_i(16) : elements[1].to_i(16) + 1

    case elements[2]
    when '2'
      x1 = x0 - side_length
      y1 = y0
    when '0'
      x1 = x0 + side_length
      y1 = y0
    when '3'
      x1 = x0
      y1 = y0 - side_length
    when '1'
      x1 = x0
      y1 = y0 + side_length
    end

    result = (x0 * y1) - (x1 * y0)
    x0 = x1
    y0 = y1
    sum + result
  end
  sum_vertices / 2
end

def build_vertices(dig_plan)
  vertices = [[0, 0]]
  x = 0
  y = 0
  ext_y = '2'
  ext_x = '1'

  dig_plan.each_with_index do |instruction, i|
    elements = instruction.split[2].match(/\(#(\w{5})(\w)\)/)
    a = dig_plan[i - 1].split[2].match(/\(#\w{5}(\w)\)/)[1]
    b = dig_plan[(i == dig_plan.size - 1 ? 0 : i + 1)].split[2].match(/\(#\w{5}(\w)\)/)[1]
    a == b ? side_length = elements[1].to_i(16) : side_length = elements[1].to_i(16) + 1

    # p "a = #{a}, b = #{b}, ext_x = #{ext_x}, ext_y = #{ext_y}"
    case elements[2]
    when '2' # L
      ext_x = invert(ext_x) unless a == b
      side_length -= 2 unless ext_x == a
      x -= side_length
    when '0' # R
      ext_x = invert(ext_x) unless a == b
      side_length -= 2 unless ext_x == a
      x += side_length
    when '1' # D
      ext_y = invert(ext_y) unless a == b
      side_length -= 2 unless ext_y == a
      y -= side_length
    when '3' # U
      ext_y = invert(ext_y) unless a == b
      side_length -= 2 unless ext_y == a
      y += side_length
    end
    # p side_length
    vertices << [x, y]
  end
  shoelace_formula(vertices)
end

def invert(direction)
  case direction
  when '2'
    '0'
  when '0'
    '2'
  when '1'
    '3'
  when '3'
    '1'
  end
end

def shoelace_formula(vertices)
  vertices.reverse!
  # pp vertices
  total = vertices.each_with_index.inject(0) do |sum, (vertex, i)|
    x0, y0 = vertices[i - 1]
    result = (x0 * vertex[1]) - (vertex[0] * y0)
    sum + result
  end
  total / 2
end

def properly_measure(dig_plan)
  instructions, grid, (x, y) = build_hex_grid(dig_plan)

  instructions.each do |instruction|
    instruction[1].times do
      grid[y][x] = '#'
      case instruction[0]
      when '2'
        x -= 1
      when '0'
        x += 1
      when '3'
        y -= 1
      when '1'
        y += 1
      end
    end
  end
  # pp grid
  # measure_area(grid)
end

def build_grid(dig_plan)
  x = 0
  y = 0
  x_min, x_max, y_min, y_max = [0, 0, 0, 0]
  instructions = []
  dig_plan.each do |instruction|
    elements = instruction.split
    instructions << [elements[0], elements[1]]
    case elements[0]
    when 'L'
      x -= elements[1].to_i
      x_min = x if x < x_min
    when 'R'
      x += elements[1].to_i
      x_max = x if x > x_max
    when 'U'
      y -= elements[1].to_i
      y_min = y if y < y_min
    when 'D'
      y += elements[1].to_i
      y_max = y if y > y_max
    end
  end
  width = x_max - x_min + 3
  height = y_max - y_min + 3
  [instructions, Array.new(height) { |_i| '.' * width }, [x_min.abs + 1, y_min.abs + 1]]
end

def build_hex_grid(dig_plan)
  x = 0
  y = 0
  x_min, x_max, y_min, y_max = [0, 0, 0, 0]
  instructions = []
  dig_plan.each do |instruction|
    elements = instruction.split[2].match(/\(#(\w{5})(\w)\)/)
    instructions << [elements[2], elements[1].to_i(16)]
    case elements[2]
    when '2'
      x -= elements[1].to_i(16)
      x_min = x if x < x_min
    when '0'
      x += elements[1].to_i(16)
      x_max = x if x > x_max
    when '3'
      y -= elements[1].to_i(16)
      y_min = y if y < y_min
    when '1'
      y += elements[1].to_i(16)
      y_max = y if y > y_max
    end
  end
  width = x_max - x_min + 3
  height = y_max - y_min + 3
  [instructions, Array.new(height) { |_i| '.' * width }, [x_min.abs + 1, y_min.abs + 1]]
end

def measure_area(grid)
  cutout(grid)
  pp grid
  grid.join.gsub(' ', '').size
end

def cutout(grid)
  queue = []
  (0...grid[0].size).each { |j| queue << [j, 0] << [j, grid.size - 1] }
  (0...grid.size).each { |i| queue << [0, i] << [grid[0].size - 1, i] }

  while !queue.empty?
    x, y = queue.shift

    next if x < 0 || y < 0 || x >= grid[0].size || y >= grid.size || grid[y][x] != '.'

    grid[y][x] = ' '

    queue << [x + 1, y] << [x - 1, y] << [x, y + 1] << [x, y - 1]
  end
end

p build_vertices(data)
# p measure(data[..50])
# p measure(data)
