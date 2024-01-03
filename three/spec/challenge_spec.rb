require_relative '../challenge'

source = [
  "467..114..",
  "...*......",
  "..35..633.",
  "......#...",
  "617*......",
  ".....+.58.",
  "..592.....",
  "......755.",
  "...$.*....",
  ".664.598..",
  "..........",
  "...245.234",
  "23..324...",
  "..$.......",
  ".........5",
  "#.......3.",
  "$.4......$"
]

RSpec.describe 'challenge#sum_part_numbers' do
  it 'should return an integer' do
    expect(sum_part_numbers(source).class).to eq(Integer)
  end

  it 'should return the sum of the game indices of possible games' do
    expect(sum_part_numbers(source)).to eq(4361+23+3)
  end
end
