#!/usr/bin/env ruby
require 'yaml'

class Node
  def initialize
    @left = nil
    @right = nil
  end
end

animal_tree = nil
if File.exists?('animals.yml')
  animal_tree = YAML.load(File.read('animals.yml'))
else
n  animal_tree = Node.new
  animal_tree.animal = 'Elephant'
end

puts 'Think of an animal...'
while true

end
