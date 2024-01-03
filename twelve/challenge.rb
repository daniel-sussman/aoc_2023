data = File.open('input.txt').read.split("\n")

def count_arrangements(source)
  result = []
  source.each do |row|
    next result << 1 unless row.include?('?')

    elements = row.split
    damaged_record = elements[0]
    contiguous_list = elements[1].split(',').map(&:to_i)
    groupings = damaged_record.split(/[.]+/).reject(&:empty?)
    possibilities = count(groupings, contiguous_list)
    result << possibilities
  end
  return result.sum
end

def count(record, list, count = 0)
  new_record = record.clone
  new_list = list.clone
  if record.empty? || list.empty?
    count += 1 if list.empty? && !record.include?("#")
    return count
  elsif record.first.size < list.first
    if record.first.include?("#")
      new_record, new_list = [[], [1]]
    else
      new_record.shift
    end
  elsif record.first[0] == '#'
    # no wiggle
    new_record, new_list = apply_list(record, list)
  else
    return count(*apply_list(new_record, new_list)) + count(*shift_record(new_record, new_list))
  end
  count(new_record, new_list, count)
end

def apply_list(record, list)
  new_record = record.clone
  new_list = list.clone
  if new_record.first[new_list.first] == '#'
    # new_record[0] = new_record.first[1..]
    # return [new_record, new_list]
    return [[], [1]]
  end

  new_record[0] = new_record.first[(new_list.first + 1)..]
  new_record.shift if !new_record.first || new_record.first.empty?
  new_list.shift
  [new_record, new_list]
end

def shift_record(record, list)
  new_record = record.clone
  new_list = list.clone

  if new_record.first[0] == '#'
    return [[], [1]]
  end

  new_record[0] = new_record.first[1..]
  [new_record, new_list]
end

p count_arrangements(data)
