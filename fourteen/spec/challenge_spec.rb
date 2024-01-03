require_relative '../challenge'

source = [
  "O....#....",
  "O.OO#....#",
  ".....##...",
  "OO.#O....O",
  ".O.....O#.",
  "O.#..O.#.#",
  "..O..#O..O",
  ".......O..",
  "#....###..",
  "#OO..#...."
]

tilted = [
  "OOOO.#.O..",
  "OO..#....#",
  "OO..O##..O",
  "O..#.OO...",
  "........#.",
  "..#....#.#",
  "..O..#.O.O",
  "..O.......",
  "#....###..",
  "#....#...."
]

# RSpec.describe 'challenge#tilt' do
#   it 'should return an array' do
#     expect(tilt(source).class).to eq(Array)
#   end

#   it 'should return the correct total' do
#     expect(tilt(source)).to eq(tilted)
#   end
# end

# RSpec.describe 'challenge#tilt' do
#   it 'should return an integer' do
#     expect(tilt(source).class).to eq(Integer)
#   end

#   it 'should return the correct total' do
#     expect(tilt(source)).to eq(136)
#   end
# end

RSpec.describe 'challenge#tilt' do
  it 'should return an integer' do
    expect(tilt(source, 10).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(tilt(source, 10)).to eq(64)
  end
end
