data = File.open('input.txt').read.split("\n\n").map{|e| e.split("\n")}

def resolve(source)
  result = []
  source.each do |section|
    result << find_reflection(section) * 100
    result << find_reflection(turn(section))
    p "ERROR" if find_reflection(section) > 0 && find_reflection(turn(section)) > 0
    pp section if find_reflection(section) == 0 && find_reflection(turn(section)) == 0
  end
  p result.sum
end

def find_reflection(section)
  i = section.size - 1
  i.times do |n|
    a = section[..n]
    b = section[n + 1..]
    compare_length = [a.size, b.size].min
    image = a[(a.length - compare_length)..a.length]
    mirror_image = b[..compare_length - 1].reverse

    if image == mirror_image
      return n + 1
    end
  end
  0
end

def turn(section)
  new = section.map { |row| row.split('') }
  new.transpose.map(&:join)
end

def resolve_with_smudge(source)
  result = []
  source.each do |section|
    result << find_smudge(section)
  end
  p result.sum
end

def find_smudge(section)
  horizontal = find_reflection(section)
  vertical = find_reflection(turn(section))

  section.each_with_index do |row, y|
    symbols = row.split('')
    symbols.each_with_index do |symbol, x|
      section[y][x] = symbol == "#" ? "." : "#"

      first_result = horizontal.positive? ? find_new_reflection(section, horizontal) : find_reflection(section)
      second_result = vertical.positive? ? find_new_reflection(turn(section), vertical) : find_reflection(turn(section))

      section[y][x] = symbol
      return first_result * 100 if first_result.positive?
      return second_result if second_result.positive?
    end
  end
  pp section
  0
end

def find_new_reflection(section, old_result)
  i = section.size - 1
  i.times do |n|
    next if (n + 1) == old_result
    a = section[..n]
    b = section[n + 1..]
    compare_length = [a.size, b.size].min
    image = a[(a.length - compare_length)..a.length]
    mirror_image = b[..compare_length - 1].reverse
    if image == mirror_image
      return n + 1
    end
  end
  0
end

resolve_with_smudge(data)
