require_relative '../challenge'

source = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"

RSpec.describe 'challenge#make_hash' do
  it 'should return an integer' do
    expect(make_hash('HASH').class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(make_hash('HASH')).to eq(52)
  end
end

RSpec.describe 'challenge#verify' do
  it 'should return an integer' do
    expect(verify(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(verify(source)).to eq(1320)
  end
end

RSpec.describe 'challenge#confirm' do
  it 'should return an integer' do
    expect(confirm(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(confirm(source)).to eq(145)
  end
end
