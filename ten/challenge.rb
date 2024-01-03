data = File.open('input.txt').read.split("\n")

def follow_pipes(map)
  x0, y0 = fetch_starting_position(map)
  x, y, d = find_connected_pipes(x0, y0, map).first
  network = []
  until [x, y] == [x0, y0]
    network << [x, y]
    x, y, d = follow(x, y, d, map)
  end
  p "Part one: #{(network.size / 2) + 1}"
  schema = Array.new(map.size) { '.' * map[0].size }
  schema[y0][x0] = 'S'
  network.each do |node|
    col, row = node
    schema[row][col] = map[row][col]
  end
  cutout_dots(schema)
  # pp schema
  # schema.join.gsub(/[^.]/, '').size
  count_bars(schema)
end

def count_bars(map)
  result = 0
  map.each do |row|
    parity = 0
    row.split('').each do |tile|
      if tile == '|'
        parity += 1
      elsif tile == '.'
        result += 1 if parity.odd?
      end
    end
  end
  result
end

def cutout_dots(grid)
  height = grid.size
  width = grid[0].size
  queue = []
  queue << [0, 0] << [0, height - 1] << [width - 1, 0] << [width - 1, height - 1]

  while !queue.empty?
    x, y = queue.shift

    next if x < 0 || y < 0 || x >= width || y >= height || grid[y][x] != '.'

    grid[y][x] = ' '

    queue << [x + 1, y] << [x - 1, y] << [x, y + 1] << [x, y - 1]
  end
end

def cutout(grid)
  height = grid.size
  width = grid[0].size
  already = {}
  queue = []
  queue << [0, 0] << [0, height - 1] << [width - 1, 0] << [width - 1, height - 1]

  while !queue.empty?
    x, y = queue.shift

    next if already["(#{x}, #{y})"]

    # can travel on lower and right borders | - L J 7 F . S
    case grid[y][x]
    when '.' # can enter a pipe network from right or bottom
      queue << [x + 1, y] if x < width - 1 && %w[. L].include?(grid[y][x + 1])
      queue << [x - 1, y] if x.positive? && %w[. J | 7].include?(grid[y][x - 1])
      queue << [x, y + 1] if y < height - 1 && %w[. 7].include?(grid[y + 1][x])
      queue << [x, y - 1] if y.positive? && %w[. J - L].include?(grid[y - 1][x])
      grid[y][x] = ' '
    when '|' # can exit network to right
      queue << [x + 1, y] if x < width - 1 && %w[. L].include?(grid[y][x + 1])
      queue << [x, y + 1] if y < height - 1 && %w[| J].include?(grid[y + 1][x])
      queue << [x, y - 1] if y.positive? && %w[| 7 F].include?(grid[y - 1][x])
    when '-' # can exit network to bottom
      queue << [x + 1, y] if x < width - 1 && %w[- J].include?(grid[y][x + 1])
      queue << [x - 1, y] if x.positive? && %w[- L F].include?(grid[y][x - 1])
      queue << [x, y + 1] if y < height - 1 && %w[. 7].include?(grid[y + 1][x])
    when 'J' # can exit network to right or bottom
      queue << [x + 1, y] if x < width - 1 && %w[. L].include?(grid[y][x + 1])
      queue << [x - 1, y] if x.positive? && %w[- L].include?(grid[y][x - 1])
      queue << [x, y + 1] if y < height - 1 && %w[. 7].include?(grid[y + 1][x])
      queue << [x, y - 1] if y.positive? && %w[| 7 F].include?(grid[y - 1][x])
    when 'L' # can exit network to left or bottom
      queue << [x + 1, y] if x < width - 1 && %w[- J].include?(grid[y][x + 1])
      queue << [x - 1, y] if x.positive? && %w[. J 7].include?(grid[y][x - 1])
      queue << [x, y + 1] if y < height - 1 && %w[. 7].include?(grid[y + 1][x])
    when '7' # can exit network to right or top
      queue << [x + 1, y] if x < width - 1 && %w[. L].include?(grid[y][x + 1])
      queue << [x, y + 1] if y < height - 1 && %w[| J].include?(grid[y + 1][x])
      queue << [x, y - 1] if y.positive? && %w[. J L].include?(grid[y - 1][x])
    when 'F' # can only follow right or down
      queue << [x + 1, y] if x < width - 1 && %w[- J].include?(grid[y][x + 1])
      queue << [x, y + 1] if y < height - 1 && %w[| J].include?(grid[y + 1][x])
    end
    already["(#{x}, #{y})"] = true
  end
end

def fetch_starting_position(map)
  width = map[0].size
  index = map.join.index('S')
  [index % width, index / width]
end

def find_connected_pipes(x, y, map)
  pipes = []
  pipes << [x, y - 1, 'n'] if ['|', '7', 'F'].include?(map[y - 1][x])
  pipes << [x, y + 1, 's'] if ['|', 'L', 'J'].include?(map[y + 1][x])
  pipes << [x - 1, y, 'w'] if ['-', 'L', 'F'].include?(map[y][x - 1])
  pipes << [x + 1, y, 'e'] if ['-', 'J', '7'].include?(map[y][x + 1])
  pipes
end

def follow(x, y, d, map)
  case map[y][x]
  when '|'
    next_x, next_y, next_d = d == 'n' ? [x, y - 1, 'n'] : [x, y + 1, 's']
  when '-'
    next_x, next_y, next_d = d == 'w' ? [x - 1, y, 'w'] : [x + 1, y, 'e']
  when 'L'
    next_x, next_y, next_d = d == 'w' ? [x, y - 1, 'n'] : [x + 1, y, 'e']
  when 'J'
    next_x, next_y, next_d = d == 's' ? [x - 1, y, 'w'] : [x, y - 1, 'n']
  when '7'
    next_x, next_y, next_d = d == 'n' ? [x - 1, y, 'w'] : [x, y + 1, 's']
  when 'F'
    next_x, next_y, next_d = d == 'n' ? [x + 1, y, 'e'] : [x, y + 1, 's']
  end
  [next_x, next_y, next_d]
end

p follow_pipes(data)
