require_relative '../challenge'

source = [
  "...#......",
  ".......#..",
  "#.........",
  "..........",
  "......#...",
  ".#........",
  ".........#",
  "..........",
  ".......#..",
  "#...#....."
]

expanded = [
  "....#........",
  ".........#...",
  "#............",
  ".............",
  ".............",
  "........#....",
  ".#...........",
  "............#",
  ".............",
  ".............",
  ".........#...",
  "#....#......."
]

RSpec.describe 'challenge#expand' do
  it 'should return an Array' do
    expect(expand(source).class).to eq(Array)
  end

  it 'should return the correct map of the universe' do
    expect(expand(source)).to eq(expanded)
  end
end

RSpec.describe 'challenge#fetch_galaxies' do
  it 'should return an Array' do
    expect(fetch_galaxies(expanded).class).to eq(Array)
  end

  it 'should return a list of the correct size' do
    expect(fetch_galaxies(expanded).size).to eq(9)
  end
end

RSpec.describe 'challenge#measure' do
  it 'should return an integer' do
    expect(measure(source).class).to eq(Integer)
  end

  it 'should return the correct value' do
    expect(measure(source)).to eq(374)
  end
end
