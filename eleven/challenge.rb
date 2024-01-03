data = File.open('input.txt').read.split("\n")

def measure(source)
  universe = expand(source)
  galaxies = fetch_galaxies(universe)
  pair_and_measure(galaxies)
end

def re_measure(source)
  universe = re_expand(source)
  galaxies = fetch_galaxies(universe)
  pair_and_re_measure(galaxies, universe)
end

def expand(source)
  rows = []
  cols = []
  universe = Marshal.load(Marshal.dump(source))

  universe[0].size.times do |i|
    cols << i if universe.all? { |row| row[i] == '.' }
  end

  universe.size.times do |j|
    rows << j if universe[j] == '.' * universe[0].size
  end

  cols.reverse.each { |i| universe.each { |row| row.insert(i, '.') } }
  rows.reverse.each { |j| universe.insert(j, universe[j])}

  universe
end

def re_expand(source)
  rows = []
  cols = []
  universe = Marshal.load(Marshal.dump(source))

  universe[0].size.times do |i|
    cols << i if universe.all? { |row| row[i] == '.' }
  end

  universe.size.times do |j|
    rows << j if universe[j] == '.' * universe[0].size
  end

  cols.reverse.each { |i| universe.each { |row| row[i] = '$' } }
  rows.reverse.each { |j| universe[j] = '$' * universe[j].size }

  universe
end

def fetch_galaxies(universe)
  list = []
  universe.each_with_index do |row, y|
    row.split('').each_with_index do |space, x|
      list << [x, y] if space == '#'
    end
  end
  list
end

def pair_and_measure(galaxies)
  distances = 0
  while true
    x, y = galaxies.shift
    return distances if galaxies.empty?
    galaxies.each do |galaxy|
      x1, y1 = galaxy
      distances += (x - x1).abs + (y - y1).abs
    end
  end
end

def pair_and_re_measure(galaxies, map)
  distances = 0
  while true
    x, y = galaxies.shift
    return distances if galaxies.empty?

    galaxies.each do |galaxy|
      x1, y1 = galaxy
      until x1 == x
        x1 > x ? x1 -= 1 : x1 += 1
        distances += map[y1][x1] == '$' ? 1_000_000 : 1
      end
      until y1 == y
        y1 > y ? y1 -= 1 : y1 += 1
        distances += map[y1][x1] == '$' ? 1_000_000 : 1
      end
    end
  end
end

# p measure(data)
p re_measure(data)
