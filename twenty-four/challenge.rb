require 'pry-byebug'

data = File.open('input.txt').read.split("\n")

def resolve(source, at_least, at_most)
  hailstones = source.clone
  result = 0
  hailstones.size.times do
    a = hailstones.shift
    hailstones.each do |b|
      pxa, pya, _pza, vxa, vya, _vza = a.split(' @ ').map { |e| e.split(', ').map(&:to_i) }.flatten
      pxb, pyb, _pzb, vxb, vyb, _vzb = b.split(' @ ').map { |e| e.split(', ').map(&:to_i) }.flatten

      slope_a = vya.fdiv(vxa)
      slope_b = vyb.fdiv(vxb)
      intercept_a = pya - vya * pxa.fdiv(vxa)
      intercept_b = pyb - vyb * pxb.fdiv(vxb)
      x = (intercept_b - intercept_a).fdiv(slope_a - slope_b)
      y = slope_a * x + intercept_a

      in_future_a = (x - pxa).fdiv(vxa) > 0
      in_future_b = (x - pxb).fdiv(vxb) > 0

      result += 1 if in_future_a && in_future_b && x >= at_least && x <= at_most && y >= at_least && y <= at_most
    end
  end
  result
end

def aim_rock(hailstones)
  hailstones.each do |hailstone|
    px, py, pz, vx, vy, vz = hailstone.split(' @ ').map { |e| e.split(', ').map(&:to_i) }.flatten
  end

  hailstones = source.clone
  hailstones.size.times do
    a = hailstones.shift
    hailstones.each do |b|
      pxa, pya, _pza, vxa, vya, _vza = a.split(' @ ').map { |e| e.split(', ').map(&:to_i) }.flatten
      pxb, pyb, _pzb, vxb, vyb, _vzb = b.split(' @ ').map { |e| e.split(', ').map(&:to_i) }.flatten

      slope_a = vya.fdiv(vxa)
      slope_b = vyb.fdiv(vxb)
      intercept_a = pya - vya * pxa.fdiv(vxa)
      intercept_b = pyb - vyb * pxb.fdiv(vxb)
      x = (intercept_b - intercept_a).fdiv(slope_a - slope_b)
      y = slope_a * x + intercept_a

      in_future_a = (x - pxa).fdiv(vxa) > 0
      in_future_b = (x - pxb).fdiv(vxb) > 0

      result += 1 if in_future_a && in_future_b && x >= at_least && x <= at_most && y >= at_least && y <= at_most
    end
  end
  result
end

# p resolve(data, 200000000000000, 400000000000000)
