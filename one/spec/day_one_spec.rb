require_relative '../day_one'

# source = ['h3hhhi4', 'nk3llll', '3n2n34n5n66n77m7', 'nen4n3n2ln20', 'nenen4nejei']

# RSpec.describe 'day_one#calibrate_and_sum' do
#   it 'should return an integer' do
#     expect(calibrate_and_sum(source).class).to eq(Integer)
#   end

#   it 'should return the sum of the first and last integers in each row' do
#     expect(calibrate_and_sum(source)).to eq(34 + 33 + 37 + 40 + 44)
#   end
# end

source = [
  "two1nine",
  "eightwothree",
  "abcone2threexyz",
  "xtwone3four",
  "4nineeightseven2",
  "zoneight234",
  "7pqrstsixteen"
]

RSpec.describe 'day_one#sum_words_and_numbers' do
  it 'should return an integer' do
    expect(sum_words_and_numbers(source).class).to eq(Integer)
  end

  it 'should return the sum of the first and last integers in each row' do
    expect(sum_words_and_numbers(source)).to eq(29 + 83 + 13 + 24 + 42 + 14 + 76)
  end
end
