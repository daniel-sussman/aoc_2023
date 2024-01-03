require_relative '../challenge'

source = [
  ["#.##..##.",
  "..#.##.#.",
  "##......#",
  "##......#",
  "..#.##.#.",
  "..##..##.",
  "#.#.##.#."],
  ["#...##..#",
  "#....#..#",
  "..##..###",
  "#####.##.",
  "#####.##.",
  "..##..###",
  "#....#..#"],
  [".#..##.##.##.",
  ".###..####..#",
  "##.####..####",
  "...##########",
  "##..##.##.##.",
  "##...........",
  ".......##....",
  "####..#..#..#",
  "##.#..####..#",
  "#...##.##.##.",
  "..##..####..#",
  "#.#..#....#..",
  "#......##...."],
  [".###.......",
  "####.......",
  ".#......#.#",
  "......##..#",
  "#.#..#..#..",
  ".#..##.##..",
  ".#..####...",
  ".####.#.#..",
  ".#.####....",
  "##.#.##..#.",
  "##.#.##..#."]
]

alt_source = [
  ["#.##..##.",
  "..#.##.#.",
  "##......#",
  "##......#",
  "..#.##.#.",
  "..##..##.",
  "#.#.##.#."],
  ["#...##..#",
  "#....#..#",
  "..##..###",
  "#####.##.",
  "#####.##.",
  "..##..###",
  "#....#..#"]
]

alt_source = [
  [".#..##.##.##.",
  ".###..####..#",
  "##.####..####",
  "...##########",
  "##..##.##.##.",
  "##...........",
  ".......##....",
  "####..#..#..#",
  "##.#..####..#",
  "#...##.##.##.",
  "..##..####..#",
  "#.#..#....#..",
  "#......##...."]
]

# RSpec.describe 'challenge#find_reflection' do
#   it 'should return an integer' do
#     expect(find_reflection(source).class).to eq(Integer)
#   end

#   it 'should return the line where the mirror is' do
#     expect(find_reflection(source)).to eq(3)
#   end
# end

RSpec.describe 'challenge#resolve' do
  it 'should return an integer' do
    expect(resolve(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(resolve(source)).to eq(405 + 8 + 1000)
  end
end

RSpec.describe 'challenge#resolve_with_smudge' do
  it 'should return an integer' do
    expect(resolve_with_smudge(alt_source).class).to eq(Integer)
  end

  # it 'should return the correct total' do
  #   expect(resolve_with_smudge(alt_source)).to eq(400)
  # end
end
