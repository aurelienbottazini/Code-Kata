#!/usr/bin/env ruby
require 'yaml'

class Node
  attr_writer :animal, :leaf

  def initialize yes_node=nil, no_node=nil
    @yes_node = yes_node
    @no_node = no_node
    @leaf = true
    @question = String.new
    @animal = String.new
  end

end

animal_tree = nil
if File.exists?('animals.yml')
  animal_tree = YAML.load(File.read('animals.yml'))
else
  animal_tree = Node.new
  animal_tree.animal = 'Elephant'
end

puts 'Think of an animal...'
while true
  animal_tree.ask
end
