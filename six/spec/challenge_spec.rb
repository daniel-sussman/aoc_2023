require_relative '../challenge'

source = [
  "Time:      7  15   30",
  "Distance:  9  40  200"
]

RSpec.describe 'challenge#resolve' do
  it 'should return an integer' do
    expect(resolve(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(resolve(source)).to eq(4 * 8 * 9)
  end
end

RSpec.describe 'challenge#properly_resolve' do
  it 'should return an integer' do
    expect(properly_resolve(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(properly_resolve(source)).to eq(71503)
  end
end
