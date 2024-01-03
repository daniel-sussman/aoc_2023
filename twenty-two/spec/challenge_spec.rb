require_relative '../challenge'

source = [
  "1,0,1~1,2,1",
  "0,0,2~2,0,2",
  "0,2,3~2,2,3",
  "0,0,4~0,2,4",
  "2,0,5~2,2,5",
  "0,1,6~2,1,6",
  "1,1,8~1,1,9"
]

RSpec.describe 'challenge#tally_safe_bricks' do
  it 'should return an integer' do
    expect(tally_safe_bricks(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(tally_safe_bricks(source)).to eq(5)
  end
end
