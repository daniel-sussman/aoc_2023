data = File.open('input.txt').read.split("\n")

def sum_possible(entries)
  hash = {}
  result = []
  entries.each do |entry|
    elements = entry.split(': ')
    key = elements[0][5..].to_i
    value = elements[1]
    hash[key] = value
  end
  hash.each do |key, value|
    reds = value.scan(/([0-9]+) red/).flatten.map(&:to_i)
    greens = value.scan(/([0-9]+) green/).flatten.map(&:to_i)
    blues = value.scan(/([0-9]+) blue/).flatten.map(&:to_i)
    if reds.none? { |n| n > 12 } && greens.none? { |n| n > 13 } && blues.none? { |n| n > 14 }
      result << key
    end
  end
  p result.sum
end

def power_minimum(entries)
  hash = {}
  result = []
  entries.each do |entry|
    elements = entry.split(': ')
    key = elements[0][5..].to_i
    value = elements[1]
    hash[key] = value
  end
  hash.each do |_key, value|
    reds = value.scan(/([0-9]+) red/).flatten.map(&:to_i)
    greens = value.scan(/([0-9]+) green/).flatten.map(&:to_i)
    blues = value.scan(/([0-9]+) blue/).flatten.map(&:to_i)
    result << reds.max * greens.max * blues.max
  end
  p result.sum
end

power_minimum(data)
