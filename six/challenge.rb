data = File.open('input.txt').read.split("\n")

def resolve(source)
  result = []

  times = source[0].split(/\s+/)[1..].map(&:to_i)
  distances = source[1].split(/\s+/)[1..].map(&:to_i)

  times.each_with_index do |time, i|
    target = distances[i]
    victory_paths = 0
    time.times do |n|
      speed = n
      distance = (time - n) * speed
      if distance > target
        victory_paths += 1
      end
    end
    result << victory_paths
  end
  p result.inject(1, :*)
end

def properly_resolve(source)
  time = source[0].gsub(/[^\d]/, '').to_i
  target = source[1].gsub(/[^\d]/, '').to_i

  min_time = target.fdiv(time).ceil
  max_time = time - min_time

  # min_time -= 1
  speed = min_time
  distance = speed * (time - min_time)
  p "Your distance: #{distance}, target: #{target}. Victory: #{distance > target}"

  p (max_time - min_time + 1)
end

def math(source)
  time = source[0].gsub(/[^\d]/, '').to_i
  target = source[1].gsub(/[^\d]/, '').to_i

  min_time = (-time + Math.sqrt(time * time - 4 * target)).fdiv(-2).ceil
  max_time = (-time - Math.sqrt(time * time - 4 * target)).fdiv(-2).floor

  (max_time - min_time + 1).abs
end

p math(data)
