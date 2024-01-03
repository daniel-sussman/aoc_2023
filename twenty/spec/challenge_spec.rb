require_relative '../challenge'

first_example = [
  "broadcaster -> a, b, c",
  "%a -> b",
  "%b -> c",
  "%c -> inv",
  "&inv -> a"
]

second_example = [
  "broadcaster -> a",
  "%a -> inv, con",
  "&inv -> b",
  "%b -> con",
  "&con -> output"
]

RSpec.describe 'challenge#push_button_1k_times' do
  it 'should return an integer' do
    expect(push_button_1k_times(first_example).class).to eq(Integer)
  end

  it 'should return the correct total for the first example' do
    expect(push_button_1k_times(first_example)).to eq(32000000)
  end

  it 'should return the correct total for the second example' do
    expect(push_button_1k_times(second_example)).to eq(11687500)
  end
end
