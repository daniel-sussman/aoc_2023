require_relative '../challenge'

source = [
  "0 3 6 9 12 15",
  "1 3 6 10 15 21",
  "10 13 16 21 30 45"
]

RSpec.describe 'challenge#extrapolate' do
  it 'should return an integer' do
    expect(extrapolate(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(extrapolate(source)).to eq(114)
  end
end

RSpec.describe 'challenge#reverse_extrapolate' do
  it 'should return an integer' do
    expect(reverse_extrapolate(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(reverse_extrapolate(source)).to eq(2)
  end
end
