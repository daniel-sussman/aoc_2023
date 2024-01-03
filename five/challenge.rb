data = File.open('input.txt').read.split(/[\n]+/)
seeds = data.find { |string| string.include?("seeds: ") }[7..].split.map(&:to_i)

big_seeds = []
seeds.each_cons(2) do |pair|
  big_seeds << pair
end

data = data[2..]

def find_location(data, seeds)
  until data.empty?
    seeds = handle(data, seeds)
    # seeds = seeds.map { |seed| process(data, seed) }
    n = data.index { |row| /[a-z]/ =~ row } || data.size - 1
    data = data[n + 1..]
  end
  seeds.min
end

def process(data, seed)
  data.each do |row|
    return seed if /[a-z]/.match(row[0])

    array = row.split.map(&:to_i)
    if seed > array[1] && seed < (array[1] + array[2])
      difference = array[0] - array[1]
      return seed += difference
    end
  end
end

def handle(data, seeds)
  seeds.each_with_index do |pair, index|
    p "handling #{index + 1} / #{seeds.length}..."
    first_seed = pair[0]
    last_seed = pair[0] + pair[1] - 1
    data.each do |row|
      return seeds if /[a-z]/.match(row[0])

      array = row.split.map(&:to_i)
      if first_seed > array[1]
        difference = array[0] - array[1]
        range_max = array[1] + array[2]
        if last_seed < range_max
          pair[0] += difference
          break
        else
          pair[0] += difference
          pair[1] = range_max - pair[0]
          seeds << [range_max, last_seed - range_max + 1]
        end
      end
    end
  end
end

p find_location(data, big_seeds)

# a = data.index("seed-to-soil map:")
# b = data.index("soil-to-fertilizer map:")
# c = data.index("fertilizer-to-water map:")
# d = data.index("water-to-light map:")
# e = data.index("light-to-temperature map:")
# f = data.index("temperature-to-humidity map:")
# g = data.index("humidity-to-location map:")

# SEED_TO_SOIL = data[(a + 1)...b]
# SOIL_TO_FERTILIZER = data[(b + 1)...c]
# FERTILIZER_TO_WATER = data[(c + 1)...d]
# WATER_TO_LIGHT = data[(d + 1)...e]
# LIGHT_TO_TEMPERATURE = data[(e + 1)...f]
# TEMPERATURE_TO_HUMIDITY = data[(f + 1)...g]
# HUMIDITY_TO_LOCATION = data[(g + 1)..]

# def soil(seed)
#   SEED_TO_SOIL.each do |row|
#     array = row.split.map(&:to_i)
#     if seed > array[1] && seed < (array[1] + array[2])
#       difference = array[0] - array[1]
#       seed += difference
#     end
#   end
#   seed
# end

# def fertilize(soil)
#   SOIL_TO_FERTILIZER.each do |row|
#     array = row.split.map(&:to_i)
#     if soil > array[1] && soil < (array[1] + array[2])
#       difference = array[0] - array[1]
#       soil += difference
#     end
#   end
#   soil
# end

# def water(fertilized_soil)
#   FERTILIZER_TO_WATER.each do |row|
#     array = row.split.map(&:to_i)
#     if fertilized_soil > array[1] && fertilized_soil < (array[1] + array[2])
#       difference = array[0] - array[1]
#       fertilized_soil += difference
#     end
#   end
#   fertilized_soil
# end

# def light(water)
#   WATER_TO_LIGHT.each do |row|
#     array = row.split.map(&:to_i)
#     if water > array[1] && water < (array[1] + array[2])
#       difference = array[0] - array[1]
#       water += difference
#     end
#   end
#   water
# end

# def temperature(light)
#   LIGHT_TO_TEMPERATURE.each do |row|
#     array = row.split.map(&:to_i)
#     if light > array[1] && light < (array[1] + array[2])
#       difference = array[0] - array[1]
#       light += difference
#     end
#   end
#   light
# end

# def humidify(temperature)
#   TEMPERATURE_TO_HUMIDITY.each do |row|
#     array = row.split.map(&:to_i)
#     if temperature > array[1] && temperature < (array[1] + array[2])
#       difference = array[0] - array[1]
#       temperature += difference
#     end
#   end
#   temperature
# end

# def locate(humidity)
#   HUMIDITY_TO_LOCATION.each do |row|
#     array = row.split.map(&:to_i)
#     if humidity > array[1] && humidity < (array[1] + array[2])
#       difference = array[0] - array[1]
#       humidity += difference
#     end
#   end
#   humidity
# end

# soils = seeds.map { |seed| soil(seed) }
# fertilizers = soils.map { |soil| fertilize(soil) }
# waters = fertilizers.map { |fertilizer| water(fertilizer) }
# lights = waters.map { |water| light(water) }
# temperatures = lights.map { |light| temperature(light) }
# humidities = temperatures.map { |temperature| humidify(temperature) }
# locations = humidities.map { |humidity| locate(humidity) }

# p locations.min
