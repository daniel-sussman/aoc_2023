original = "???.###"
record = ["???", "###"]
list = [1, 1, 3]

# original = ".??..??...?##."
# record = ["??", "??", "?##"]
# list = [1, 1, 3]

original = "?#?#?#?#?#?#?#?"
record = ["?#?#?#?#?#?#?#?"]
list = [1, 3, 1, 6]

original = "????.######..#####."
record = ["????", "######", "#####"]
list = [1, 6, 5]

original = "?###????????"
record = ["?###????????"]
list = [3, 2, 1]

def count(record, list, count = 0)
  p "count: #{count}"
  p record, list
  p "------"
  new_record = record.clone
  new_list = list.clone
  if record.empty? || list.empty?
    puts "No more record"
    count += 1 if list.empty?
    return count
  elsif record.first.size < list.first
    new_record.shift
  elsif record.first[0] == '#' || record.first.size == list.first || count(*shift_record(new_record, new_list)) == count
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
    return [[], new_list]
  end

  new_record[0] = new_record.first[(new_list.first + 1)..]
  new_record.shift if !new_record.first || new_record.first.empty?
  new_list.shift
  [new_record, new_list]
end

def shift_record(record, list)
  new_record = record.clone
  new_list = list.clone

  new_record[0] = new_record.first[1..]
  [new_record, new_list]
end

p original, list
p "Performing algorithm..."
p count(record, list)
