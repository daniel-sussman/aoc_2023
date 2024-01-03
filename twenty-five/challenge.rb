require 'set'
require 'pry-byebug'

data = File.open('input.txt').read.split("\n")

def solve(source)
  nodes = Set.new
  edges = []

  source.each do |line|
    a, b = line.split(': ')
    nodes << [a]
    b.split.each do |e|
      nodes << [e]
      edges << [a, e] unless edges.include?([e, a])
    end
  end

  # find longest path
  longest_path = []

end

def resolve(source)

  # procedure contract(G = (V, E)):
  # while |V| > 2
  #   choose e ∈ E uniformly at random
  #   G <-- G / e
  # return the only cut in G
  edges = []

  until edges.size == 3
    nodes = Set.new
    edges = []
    original_edges = {}
    hash = {}

    source.each do |line|
      a, b = line.split(': ')
      nodes << [a]
      b.split.each do |e|
        nodes << [e]
        edges << [a, e] unless edges.include?([e, a])
      end
    end
    edges.each_with_index { |edge, index| hash[edge] = index }
    edges_copy = Marshal.load(Marshal.dump(edges))
    edges_copy.each_with_index { |edge, index| original_edges[index] = edge }

    while nodes.size > 2
      a, b = edges.sample

      combined_node = [a, b].flatten
      edges.delete([a, b])
      hash.delete([a, b])
      nodes.delete([a])
      nodes.delete([b])
      nodes.delete(a)
      nodes.delete(b)
      nodes << combined_node # combine the two nodes into one
      edges.select { |edge| edge.include?(a) || edge.include?(b) }.each do |edge|
        edge[0] = combined_node if edge[0] == a || edge[0] == b
        edge[1] = combined_node if edge[1] == a || edge[1] == b
      end
      # hash.select { |edge| edge.include?(a) || edge.include?(b) }.each do |edge|
      #   edge[0] = combined_node if edge[0] == a || edge[0] == b
      #   edge[1] = combined_node if edge[1] == a || edge[1] == b
      # end
      # edges = edges.uniq
      edges.reject! { |edge| edge[0] == edge[1] }
      hash.reject! { |edge| edge[0] == edge[1] }
    end

  end
  # pp nodes
  result = []
  hash.rehash
  edges.each do |edge|
    a = hash[edge]
    binding.pry
    hash.delete(edge)
    result << original_edges[a]
    # binding.pry
    # hash.each do |key, value|
    #   if key == edge
    #     binding.pry
    #     a = value
    #     result << original_edges[a]
    #     hash.delete(key)
    #   end
  end
  p result
  # pp min_cut = edges[0]
  # hash.each { |key, value| a = value if key == min_cut }

  # p "cut at #{original_edges[a]}"

  # above this line

  # nodes.each do |node|
  #   nodelist[node] = edges.select { |edge| edge[0] == node || edge[1] == node }
  # end

  # hash = Hash.new { |hash, key| hash[key] = [] }
  # source.each do |line|
  #   a, b = line.split(': ')
  #   b.split.each do |e|
  #     hash[a] << e
  #     hash[e] << a
  #   end
  # end
  # pp hash
end

def karger(source)

  # procedure contract(G = (V, E)):
  # while |V| > 2
  #   choose e ∈ E uniformly at random
  #   G <-- G / e
  # return the only cut in G
  edges = []

  until edges.size == 3
    nodes = Set.new
    edges = []
    hash = {}

    source.each do |line|
      a, b = line.split(': ')
      nodes << [a]
      b.split.each do |e|
        nodes << [e]
        edges << [a, e] unless edges.include?([e, a])
      end
    end

    nodes_copy = Marshal.load(Marshal.dump(nodes))
    edges_copy = Marshal.load(Marshal.dump(edges))

    edges.each { |edge| hash[edge] = edge.clone }

    p "trying karger's algorithm..."
    while nodes.size > 2
      random_edge = edges.sample
      a, b = random_edge

      combined_node = [a, b].flatten

      edges.delete(random_edge)

      nodes.delete([a])
      nodes.delete([b])
      nodes.delete(a)
      nodes.delete(b)
      nodes << combined_node # combine the two nodes into one
      edges.select { |edge| edge.include?(a) || edge.include?(b) }.each do |edge|
        edge[0] = combined_node if edge[0] == a || edge[0] == b
        edge[1] = combined_node if edge[1] == a || edge[1] == b
      end

      edges.reject! { |edge| edge[0] == edge[1] }
    end
  end

  p "Found three edges..."
  result = []
  edges.each do |edge|
    a = hash.select { |key, value| key == edge }
    a.each_value { |value| result << value }
  end
  result = result[..2]

  p "Result was #{result}"

  p "Now severing those edges and reconstituting nodes..."
  # now sever those nodes and recreate the groups

  result.each do |edge|
    edges_copy.delete(edge)
  end

  groups = []
  edges_copy.each do |edge|
    a, b = edge
    existing_group = groups.find { |group| group.include?(a) || group.include?(b) }
    if existing_group
      existing_group << a << b
    else
      groups << edge
    end
  end
  p consolidate(groups).size
  a, b = consolidate(groups)
  p a.size * b.size
end

def consolidate(arrays)
  consolidated = []

  arrays.each do |sub_array|
    merged = consolidated.find { |cons_array| !(cons_array & sub_array).empty? }

    if merged
      merged |= sub_array
    else
      consolidated << sub_array
    end
  end

  consolidated.map!(&:uniq)
end

# Mark all nodes unvisited. Create a set of all the unvisited nodes called the unvisited set.
# Assign to every node a tentative distance value: set it to zero for our initial node and to infinity for all other nodes. During the run of the algorithm, the tentative distance of a node v is the length of the shortest path discovered so far between the node v and the starting node. Since initially no path is known to any other vertex than the source itself (which is a path of length zero), all other tentative distances are initially set to infinity. Set the initial node as current.[17]
# For the current node, consider all of its unvisited neighbors and calculate their tentative distances through the current node. Compare the newly calculated tentative distance to the one currently assigned to the neighbor and assign it the smaller one. For example, if the current node A is marked with a distance of 6, and the edge connecting it with a neighbor B has length 2, then the distance to B through A will be 6 + 2 = 8. If B was previously marked with a distance greater than 8 then change it to 8. Otherwise, the current value will be kept.
# When we are done considering all of the unvisited neighbors of the current node, mark the current node as visited and remove it from the unvisited set. A visited node will never be checked again (this is valid and optimal in connection with the behavior in step 6.: that the next nodes to visit will always be in the order of 'smallest distance from initial node first' so any visits after would have a greater distance).
# If the destination node has been marked visited (when planning a route between two specific nodes) or if the smallest tentative distance among the nodes in the unvisited set is infinity (when planning a complete traversal; occurs when there is no connection between the initial node and remaining unvisited nodes), then stop. The algorithm has finished.
# Otherwise, select the unvisited node that is marked with the smallest tentative distance, set it as the new current node, and go back to step 3.

def dijkstra(source)
  nodes = Set.new
  edges = []
  neighbors = Hash.new { |hash, key| hash[key] = Set.new }

  source.each do |line|
    a, b = line.split(': ')
    nodes << a
    b.split.each do |e|
      nodes << e
      neighbors[a] << e
      neighbors[e] << a
      edges << [a, e] unless edges.include?([e, a])
    end
  end

  dijkstra_results = []
  7.times do
    tentative_distance = {}
    nodes.each { |node| tentative_distance[node] = Float::INFINITY }
    unvisited = nodes.map(&:to_s)

    initial_node = unvisited.sample
    tentative_distance[initial_node] = 0

    until unvisited.empty?
      current_node = unvisited.min_by { |node| tentative_distance[node] }
      break if tentative_distance[current_node] == Float::INFINITY

      neighbors[current_node].select { |neighbor| unvisited.include?(neighbor) }.each do |neighbor|
        tentative_distance[neighbor] = tentative_distance[current_node] + 1
      end
      unvisited.delete(current_node)
    end

    dijkstra_results << [initial_node, current_node, tentative_distance[current_node]]
  end

  a, b = dijkstra_results.max_by { |result| result[2] }
  group_a = [a]
  group_b = [b]

end


def figure_out(source)
  nodes = Set.new
  edges = []
  neighbors = Hash.new { |hash, key| hash[key] = Set.new }

  source.each do |line|
    a, b = line.split(': ')
    nodes << a
    b.split.each do |e|
      nodes << e
      neighbors[a] << e
      neighbors[e] << a
      edges << [a, e] unless edges.include?([e, a])
    end
  end

  group_a = nodes.map(&:to_s)
  group_b = []
  until group_a.inject(0) { |sum, node| sum + neighbors[node].select { |n| group_b.include?(n) }.size } == 3
    external_node = group_a.max_by { |node| neighbors[node].select { |n| group_b.include?(n) }.size }
    group_b << external_node
    group_a.delete(external_node)
    p "GROUP A: #{group_a.size} - GROUP B: #{group_b.size}"
  end
  group_a.size * group_b.size
end

p figure_out(data)
