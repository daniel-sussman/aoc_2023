data = File.open('input.txt').read.split("\n")

def extrapolate(source)
  source.inject(0) do |sum, set|
    levels = [set.split.map(&:to_i)]
    while levels.last.uniq.size > 1
      sequence = []
      levels.last.each_cons(2) do |a, b|
        sequence << b - a
      end
      levels << sequence
    end
    while levels.size > 1
      levels[-2].push(levels[-2][-1] + levels.last.last)
      levels.pop
    end
    sum + levels.first.last
  end
end

def reverse_extrapolate(source)
  source.inject(0) do |sum, set|
    levels = [set.split.map(&:to_i)]
    while levels.last.uniq.size > 1
      sequence = []
      levels.last.each_cons(2) do |a, b|
        sequence << b - a
      end
      levels << sequence
    end
    while levels.size > 1
      levels[-2].unshift(levels[-2][0] - levels.last.first)
      levels.pop
    end
    sum + levels.first.first
  end
end

p extrapolate(data)
p reverse_extrapolate(data)
