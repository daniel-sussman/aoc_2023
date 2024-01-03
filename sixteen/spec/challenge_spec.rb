require_relative '../challenge'

source = [
  ".|...\\....",
  "|.-.\\.....",
  ".....|-...",
  "........|.",
  "..........",
  ".........\\",
  "..../.\\\\..",
  ".-.-/..|..",
  ".|....-|.\\",
  "..//.|...."
]

RSpec.describe 'challenge#analyze' do
  it 'should return an integer' do
    expect(analyze(source, 0, 0, 'e').class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(analyze(source, 0, 0, 'e')).to eq(46)
  end
end

RSpec.describe 'challenge#optimize' do
  it 'should return an integer' do
    expect(optimize(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(optimize(source)).to eq(51)
  end
end
