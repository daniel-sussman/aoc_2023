require_relative '../challenge'

source = [
  "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
  "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
  "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
  "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
  "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
]

RSpec.describe 'challenge#sum_possible' do
  it 'should return an integer' do
    expect(sum_possible(source).class).to eq(Integer)
  end

  it 'should return the sum of the game indices of possible games' do
    expect(sum_possible(source)).to eq(8)
  end
end

RSpec.describe 'challenge#power_minimum' do
  it 'should return an integer' do
    expect(power_minimum(source).class).to eq(Integer)
  end

  it 'should return the sum of powers of minimal games' do
    expect(power_minimum(source)).to eq(2286)
  end
end
