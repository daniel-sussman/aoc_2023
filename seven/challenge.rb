# frozen_string_literal: true
require 'pry-byebug'

data = File.open('input.txt').read.split("\n")

# def score_part_one(source)
#   lookup = {
#     "A" => 14,
#     "K" => 13,
#     "Q" => 12,
#     "J" => 11,
#     "T" => 10
#   }
#   bids = {}
#   sorted = [[],[],[],[],[],[],[]]
#   source.each do |group|
#     elements = group.split
#     bids[elements[0]] = elements[1].to_i
#     classify(elements[0], sorted)
#   end
#   sorted.each_with_index do |group, i|
#     sorted[i] = group.sort do |a, b|
#       aa = a.split('').map{ |card| lookup[card] || card.to_i }
#       bb = b.split('').map{ |card| lookup[card] || card.to_i }
#       sort_cards(aa, bb)
#     end
#   end
#   pp sorted
#   sorted.flatten!
#   size = sorted.size
#   winnings = []
#   sorted.each_with_index do |hand, i|
#     "hand: #{hand}, multiplier: #{size - i}, bid: #{bids[hand]}, total: #{(size - i) * bids[hand]}"
#     winnings << (size - i) * bids[hand]
#   end
#   winnings.sum
# end

def score(source)
  lookup = {
    "A" => 14,
    "K" => 13,
    "Q" => 12,
    "J" => 1,
    "T" => 10
  }
  bids = {}
  sorted = [[],[],[],[],[],[],[]]
  source.each do |group|
    elements = group.split
    bids[elements[0]] = elements[1].to_i
    hand = process_wildcards(elements[0])
    classify(elements[0], hand, sorted) # must put original hand into array, not amended one
  end
  sorted.each_with_index do |group, i|
    sorted[i] = group.sort do |a, b|
      aa = a.split('').map{ |card| lookup[card] || card.to_i }
      bb = b.split('').map{ |card| lookup[card] || card.to_i }
      sort_cards(aa, bb)
    end
  end
  # pp sorted
  sorted.flatten!
  size = sorted.size
  winnings = []
  sorted.each_with_index do |hand, i|
    # "hand: #{hand}, multiplier: #{size - i}, bid: #{bids[hand]}, total: #{(size - i) * bids[hand]}"
    winnings << (size - i) * bids[hand]
  end
  winnings.sum
end

def process_wildcards(hand)
  minus_jacks = hand.split('').reject { |card| card == "J" }
  if minus_jacks.size < hand.size
    histogram = minus_jacks.inject(Hash.new(0)) { |hash, x| hash[x] += 1; hash}
    primary_card = minus_jacks.sort_by { |x| [histogram[x] * -1, x] }.first
    primary_card ? hand.gsub("J", primary_card) : hand
  else
    hand
  end
end

def sort_cards(a, b)
  p "ERROR" unless a[0]
  a[0] == b[0] ? sort_cards(a[1..], b[1..]) : b[0] - a[0]
end

def classify(hand, amended_hand, list)
  # cards = hand.split('').map{ |card| lookup[card] || card.to_i }
  cards = amended_hand.split('')
  if cards.uniq.size == 1 # five of a kind
    list[0] << hand
  elsif /(.)\1{3}/.match(cards.sort.join) # four of a kind
    list[1] << hand
  elsif cards.uniq.size == 5
    list[6] << hand
  elsif /(.)\1{2}/.match(cards.sort.join) && cards.uniq.size == 2 # full house
    list[2] << hand
  elsif /(.)\1{2}/.match(cards.sort.join) # three of a kind
    list[3] << hand
  elsif cards.uniq.size == 3 # two pair
    list[4] << hand
  else # one pair
    list[5] << hand
  end
end

p score(data)
