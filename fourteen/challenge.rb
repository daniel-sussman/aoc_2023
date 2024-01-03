data = File.open('input.txt').read.split("\n")

# def tilt(source)
#   result = 0
#   source.each_with_index do |row, y|
#     total_rows = source.size
#     row.split('').each_with_index do |element, x|
#       if element == "O"
#         x_end, y_end = roll(x, y, source)
#         source[y][x] = "."
#         source[y_end][x_end] = "O"
#         result += total_rows - y_end
#       end
#     end
#   end
#   result
# end

# def roll(x, y, platform)
#   if y == 0 || platform[y - 1][x] != "."
#     return [x, y]
#   else
#     roll(x, y - 1, platform)
#   end
# end

# p tilt(data)

def tilt(source, cycles)
  # last_result = 0
  total_rows = source.size
  cycles.times do
    # cycle_result = 0
    source.each_with_index do |row, y|
      row.split('').each_with_index do |element, x|
        if element == "O"
          x_end, y_end = roll_north(x, y, source)
          source[y][x] = "."
          source[y_end][x_end] = "O"
          # cycle_result += total_rows - y_end
        end
      end
    end
    # source.each { |row| pp row } ; p "n----"
    source.each_with_index do |row, y|
      row.split('').each_with_index do |element, x|
        if element == "O"
          x_end, y_end = roll_west(x, y, source)
          source[y][x] = "."
          source[y_end][x_end] = "O"
          # cycle_result += total_rows - y_end
        end
      end
    end
    # source.each { |row| pp row } ; p "w-----"
    source.reverse!
    source.each_with_index do |row, y|
      row.split('').each_with_index do |element, x|
        if element == "O"
          x_end, y_end = roll_north(x, y, source)
          source[y][x] = "."
          source[y_end][x_end] = "O"
          # cycle_result += total_rows - y_end
        end
      end
    end
    source.reverse!
    # source.each { |row| pp row } ; p "s-----"
    source.each_with_index do |row, y| # working?
      row.reverse!
      row.split('').each_with_index do |element, x|
        if element == "O"
          x_end, y_end = roll_west(x, y, source)
          source[y][x] = "."
          source[y_end][x_end] = "O"
          # cycle_result += y_end
        end
      end
      row.reverse!
    end
    # source.each { |row| pp row } ; p "cycle---------"
    # new_result = weigh(source)
    # if new_result == last_result
    #   p "repeated"
    #   return last_result
    # else
    #   last_result = new_result
    # end
  end
  # source.each { |row| pp row } ; p "final-result----"
  # result
  return weigh(source)
end

def roll_north(x, y, platform)
  if y == 0 || platform[y - 1][x] != "."
    return [x, y]
  else
    roll_north(x, y - 1, platform)
  end
end

def roll_west(x, y, platform)
  if x == 0 || platform[y][x - 1] != "."
    return [x, y]
  else
    roll_west(x - 1, y, platform)
  end
end

def weigh(source)
  result = 0
  source.each_with_index do |row, y|
    total_rows = source.size
    row.split('').each_with_index do |element, x|
      if element == "O"
        result += total_rows - y
      end
    end
  end
  result
end

# def roll_south(x, y, platform) # not working
#   if platform[y + 1] && platform[y + 1][x] == "."
#     roll_south(x, y + 1, platform)
#   else
#     return [x, y]
#   end
# end

# def roll_east(x, y, platform) # not working
#   if platform[0][x + 1] && platform[y][x + 1] == "."
#     roll_east(x + 1, y, platform)
#   else
#     return [x, y]
#   end
# end

p tilt(data, 817)
