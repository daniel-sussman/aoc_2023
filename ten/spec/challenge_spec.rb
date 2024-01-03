require_relative '../challenge'

source = [
  ".F----7F7F7F7F-7....",
  ".|F--7||||||||FJ....",
  ".||.FJ||||||||L7....",
  "FJL7L7LJLJ||LJ.L-7..",
  "L--J.L7...LJS7F-7L7.",
  "....F-J..F7FJ|L7L7L7",
  "....L7.F7||L7|.L7L7|",
  ".....|FJLJ|FJ|F7|.LJ",
  "....FJL-7.||.||||...",
  "....L---J.LJ.LJLJ..."
]

RSpec.describe 'challenge#follow_pipes' do
  it 'should return an integer' do
    expect(follow_pipes(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(follow_pipes(source)).to eq(8)
  end
end
