require_relative '../challenge'

source = [
  "...........",
  ".....###.#.",
  ".###.##..#.",
  "..#.#...#..",
  "....#.#....",
  ".##..S####.",
  ".##..#...#.",
  ".......##..",
  ".##.#.####.",
  ".##..##.##.",
  "..........."
]

RSpec.describe 'challenge#count_steps' do
  it 'should return an integer' do
    expect(count_steps(source, 6).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(count_steps(source, 6)).to eq(16)
  end
end
