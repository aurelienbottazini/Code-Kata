def random_edge(adjacency_list)
  keys = adjacency_list.keys
  vertex = keys[rand(keys.size)]
  other_vertex = adjacency_list[vertex][rand(adjacency_list[vertex]
                                           .size)]
  [vertex, other_vertex]
end

def merge(adjacency_list, edge)
  #remove edge and self loops
  adjacency_list[edge[0]].delete(edge[1])
  adjacency_list[edge[1]].delete(edge[0])

  #merging
  adjacency_list[edge[0]].concat(adjacency_list[edge[1]])
  adjacency_list.delete(edge[1])

  adjacency_list.each do |(key, value)|
    count = value.count(edge[1])
    if count > 0
      value.delete(edge[1])
      # add correct numbers
      value.concat(Array.new(count, edge[0]))
    end
  end

  nil
end

i = 0
lines = File.open('./kargerMinCut.txt', 'r').readlines
mincut = Float::INFINITY

# running enough time so that random algorithm gets correct solution
while i < 100
  adjacency_list = {}
  lines.each do |l|
    edge, vertices = l.split(/\t/, 2)
    adjacency_list[edge.to_i] = vertices.split.map(&:to_i)
  end

  while adjacency_list.size > 2
    merge(adjacency_list, (random_edge adjacency_list))
  end

  tmp_mincut = adjacency_list.first[1].size
  mincut = tmp_mincut if mincut > tmp_mincut
  i += 1
end

puts mincut
