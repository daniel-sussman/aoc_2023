data = File.open('input.txt').read.split("\n")

def count_steps(map, steps)
  x, y = fetch_starting_position(map)
  take_a_step(x, y, map, steps)
end

def fetch_starting_position(map)
  width = map[0].size
  index = map.join.index('S')
  [index % width, index / width]
end

def take_a_step(x, y, map, steps)
  queue = [[x, y, 0]]
  count = []
  hash = {}

  while !queue.empty?
    x, y, step = queue.shift
    unless hash[step]
      p "Step: #{step}, currently #{queue.size} in queue..."
      hash[step] = true
    end
    next if x.negative? || y.negative? || x >= map[0].size || y >= map.size || map[y][x] == '#'
    next count << [x, y] if step == steps

    queue << [x + 1, y, step + 1] unless queue.include?([x + 1, y, step + 1])
    queue << [x - 1, y, step + 1] unless queue.include?([x - 1, y, step + 1])
    queue << [x, y + 1, step + 1] unless queue.include?([x, y + 1, step + 1])
    queue << [x, y - 1, step + 1] unless queue.include?([x, y - 1, step + 1])
  end
  count.uniq.size
end

p count_steps(data, 64)
