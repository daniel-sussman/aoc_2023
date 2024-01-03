data = File.open('input.txt').read.split("\n")

def sum_part_numbers(source)
  row_hash = Hash.new { |hash, key| hash[key] = [] }
  numbers = []

  source.each_with_index do |row, row_index|
    raw = row.clone
    i = 0
    num = 0
    while num
      num = /[0-9]+/.match(raw)
      if num
        start_index = (raw =~ /[0-9]+/) + i
        end_index = start_index + num[0].size
        i = end_index
        row_hash[row_index] << (((start_index - 1).negative? ? 0 : start_index - 1)..(end_index + 1)).to_a
        raw = row[end_index..]
      end
    end
  end

  source.each_with_index do |row, row_index|
    numbers_in_row = row.scan(/[0-9]+/)
    row_hash[row_index].each_with_index do |set, set_index|
      adjacent = false
      #check row above
      if row_index > 0
        string = source[row_index - 1]
        if check_for_symbols(string, set)
          adjacent = true
        end
      end
      #check this row
      string = source[row_index]
      if check_for_symbols(string, set)
        adjacent = true
      end
      #check row below
      if row_index < (source.size - 1)
        string = source[row_index + 1]
        if check_for_symbols(string, set)
          adjacent = true
        end
      end
      if adjacent
        numbers << numbers_in_row[set_index].to_i
      end
    end
  end
  p numbers.sum
  # pp row_hash

  # source.each_with_index do |row, y|
  #   row.split('').each_with_index do |char, x|
  #     if /[^0-9.]/.match?(char)
  #       p "[#{y}, #{x}]"
  #     end
  #   end
  #   # p row.scan(/[^0-9.]/)
  # end
end

def check_for_symbols(string, indices)
  array = string.split('')
  indices.any? { |x| /[^0-9.]/.match(array[x]) }
end

sum_part_numbers(data)
