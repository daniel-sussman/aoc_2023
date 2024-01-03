data = File.open('input.txt').read.split("\n")

def navigate(map)
  network = {}
  instructions = map[0]
  node_list = map[2..]

  node_list.each do |node|
    elements = /(\w{3}) = \((\w{3}), (\w{3})\)/.match(node)
    network[elements[1]] = [elements[2], elements[3]]
  end

  location = "AAA"
  i = 0
  steps = 0
  until location == "ZZZ"
    options = network[location]
    i = 0 if i > instructions.size - 1
    location = instructions[i] == 'L' ? options[0] : options[1]
    i += 1
    steps += 1
  end
  steps
end

def ghost(map)
  network = {}
  instructions = map[0]
  node_list = map[2..]

  node_list.each do |node|
    elements = /(\w{3}) = \((\w{3}), (\w{3})\)/.match(node)
    network[elements[1]] = [elements[2], elements[3]]
  end
  locations = network.keys.select { |node| node[-1] == 'A' }
  i = 0
  steps = 0
  # until locations.all? { |node| node[-1] == 'Z' }
  #   i = 0 if i == instructions.size
  #   locations.map! do |location|
  #     options = network[location]
  #     instructions[i] == 'L' ? options[0] : options[1]
  #   end
  #   i += 1
  #   steps += 1
  # end
  n = []
  locations.each do |location|
    until location[-1] == 'Z'
      i = 0 if i == instructions.size
      options = network[location]
      location = instructions[i] == 'L' ? options[0] : options[1]
      i += 1
      steps += 1
    end
    n << steps
  end
  n[0].lcm(n[1]).lcm(n[2]).lcm(n[3]).lcm(n[4]).lcm(n[5])
end

# p navigate(data)
p ghost(data)
