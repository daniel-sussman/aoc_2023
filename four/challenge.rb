data = File.open('input.txt').read.split("\n")

def sum_winnings(source)
  total = 0
  source.each do |card|
    numbers = card.split(": ")[1]
    all_numbers = numbers.gsub(/[^0-9 ]/,"").split(/ +/)
    win_count = all_numbers.length - all_numbers.uniq.length
    total += 2**(win_count - 1) if win_count > 0
  end
  p total
end

def sum_cards(source)
  card_count = Hash.new(1)
  source.each do |card|
    elements = card.split(": ")
    key = elements[0][5..].strip.to_i
    numbers = card.split(": ")[1]
    all_numbers = numbers.gsub(/[^0-9 ]/,"").split(/ +/)
    win_count = all_numbers.length - all_numbers.uniq.length
    if win_count.positive?
      win_count.times do |i|
        card_count[key + i + 1] += card_count[key]
      end
    end
    card_count[key] = card_count[key]
  end
  p card_count.values.sum
end

sum_cards(data)
