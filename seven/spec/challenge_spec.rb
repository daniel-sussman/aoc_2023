require_relative '../challenge'

source = [
  "32T3K 765",
  "T55J5 684",
  "KK677 28",
  "KTJJT 220",
  "QQQJA 483"
]

RSpec.describe 'challenge#score' do
  it 'should return an integer' do
    expect(score(source).class).to eq(Integer)
  end

  it 'should return the total winnings of all hands' do
    expect(score(source)).to eq(5905)
  end
end

# RSpec.describe 'challenge#classify' do
#   it 'should return an array' do
#     expect(classify(source).class).to eq(Integer)
#   end

#   it 'should return the total amount of cards won' do
#     expect(classify(source)).to eq(30)
#   end
# end
