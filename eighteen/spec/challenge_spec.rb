require_relative '../challenge'

source = [
  "R 6 (#70c710)",
  "D 5 (#0dc571)",
  "L 2 (#5713f0)",
  "D 2 (#d2c081)",
  "R 2 (#59c680)",
  "D 2 (#411b91)",
  "L 5 (#8ceee2)",
  "U 2 (#caa173)",
  "L 1 (#1b58a2)",
  "U 2 (#caa171)",
  "R 2 (#7807d2)",
  "U 3 (#a77fa3)",
  "L 2 (#015232)",
  "U 2 (#7a21e3)"
]

simple_test = [
  "R 6 (#000060)",
  "D 5 (#000051)",
  "L 2 (#000022)",
  "D 2 (#000021)",
  "R 2 (#000020)",
  "D 2 (#000021)",
  "L 5 (#000052)",
  "U 2 (#000023)",
  "L 1 (#000012)",
  "U 2 (#000023)",
  "R 2 (#000020)",
  "U 3 (#000033)",
  "L 2 (#000022)",
  "U 2 (#000023)"
]

RSpec.describe 'challenge#measure' do
  it 'should return an integer' do
    expect(measure(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(measure(source)).to eq(62)
  end
end

# RSpec.describe 'challenge#build_sides' do
#   it 'should return an integer' do
#     expect(build_sides(source).class).to eq(Integer)
#   end

#   it 'should ace the simple test case' do
#     expect(build_sides(simple_test)).to eq(62)
#   end

#   it 'should return the correct total' do
#     expect(build_sides(source)).to eq(952408144115)
#   end
# end

RSpec.describe 'challenge#build_vertices' do
  it 'should return an integer' do
    expect(build_vertices(simple_test).class).to eq(Integer)
  end

  it 'should ace the simple test case' do
    expect(build_vertices(simple_test)).to eq(62)
  end
end
