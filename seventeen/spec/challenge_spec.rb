require_relative '../challenge'

source = [
  "2413432311323",
  "3215453535623",
  "3255245654254",
  "3446585845452",
  "4546657867536",
  "1438598798454",
  "4457876987766",
  "3637877979653",
  "4654967986887",
  "4564679986453",
  "1224686865563",
  "2546548887735",
  "4322674655533"
]

RSpec.describe 'challenge#fetch_path' do
  it 'should return an integer' do
    expect(fetch_path(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(fetch_path(source)).to eq(102)
  end
end

# RSpec.describe 'challenge#find_best_path' do
#   it 'should return an integer' do
#     expect(find_best_path(source).class).to eq(Integer)
#   end

#   it 'should return the correct total' do
#     expect(find_best_path(source)).to eq(102)
#   end
# end
