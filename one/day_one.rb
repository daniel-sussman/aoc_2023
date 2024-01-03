entries = File.open('input.txt').read.split

# def calibrate_and_sum(entries_array)
#   result = []
#   entries_array.each do |entry|
#     numerals = entry.gsub(/[^0-9]/, '')
#     first = numerals[0]
#     last = numerals[-1]
#     number = "#{first}#{last}"
#     result << number.to_i
#   end
#   result.sum
# end

def sum_words_and_numbers(entries_array)
  hash = {
    one: '1',
    two: '2',
    three: '3',
    four: '4',
    five: '5',
    six: '6',
    seven: '7',
    eight: '8',
    nine: '9'
  }

  sum = 0
  entries_array.each do |entry|
    numbers = {}
    # p entry
    # find first digit
    # find last digit
    entry.split('').each_with_index do |char, index|
      if char.match?(/[0-9]/)
        numbers[index] = char
      end
    end
    hash.each do |key, value|
      i = 0
      while i
        index = entry.index(key.to_s, i)
        if index
          numbers[index] = value
          i = index + 1
        else
          i = false
        end
      end
    end
    min_index = (numbers.keys.min_by { |key| key.to_i })
    max_index = (numbers.keys.max_by { |key| key.to_i })
    first_num = numbers[min_index]
    last_num = numbers[max_index]
    number = "#{first_num}#{last_num}"
    # numerals = entry
    # hash.each do |key, value|
    #   numerals.gsub!(key.to_s, value)
    # end
    # numerals.gsub!(/[^0-9]/, '')
    # first = numerals[0]
    # last = numerals[-1]
    # number = "#{first}#{last}"
    # p number
    sum += number.to_i
  end
  sum
end

p sum_words_and_numbers(entries)
