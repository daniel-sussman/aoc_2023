require_relative '../challenge'

source = [
  "RL",
  "",
  "AAA = (BBB, CCC)",
  "BBB = (DDD, EEE)",
  "CCC = (ZZZ, GGG)",
  "DDD = (DDD, DDD)",
  "EEE = (EEE, EEE)",
  "GGG = (GGG, GGG)",
  "ZZZ = (ZZZ, ZZZ)"
]

part_two = [
  "LR",
  "",
  "11A = (11B, XXX)",
  "11B = (XXX, 11Z)",
  "11Z = (11B, XXX)",
  "22A = (22B, XXX)",
  "22B = (22C, 22C)",
  "22C = (22Z, 22Z)",
  "22Z = (22B, 22B)",
  "XXX = (XXX, XXX)"
]

RSpec.describe 'challenge#navigate' do
  it 'should return an integer' do
    expect(navigate(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(navigate(source)).to eq(2)
  end
end

RSpec.describe 'challenge#ghost' do
  it 'should return an integer' do
    expect(ghost(part_two).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(ghost(part_two)).to eq(6)
  end
end
