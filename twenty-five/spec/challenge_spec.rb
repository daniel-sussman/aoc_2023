require_relative '../challenge'

source = [
  "jqt: rhn xhk nvd",
  "rsh: frs pzl lsr",
  "xhk: hfx",
  "cmg: qnr nvd lhk bvb",
  "rhn: xhk bvb hfx",
  "bvb: xhk hfx",
  "pzl: lsr hfx nvd",
  "qnr: nvd",
  "ntq: jqt hfx bvb xhk",
  "nvd: lhk",
  "lsr: lhk",
  "rzs: qnr cmg lsr rsh",
  "frs: qnr lhk lsr"
]

RSpec.describe 'challenge#figure_out' do
  it 'should return an integer' do
    expect(figure_out(source).class).to eq(Integer)
  end

  it 'should return the correct total' do
    expect(figure_out(source)).to eq(54)
  end
end
