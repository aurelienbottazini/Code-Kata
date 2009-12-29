#!/usr/bin/env ruby -w
require 'yaml'

class Node
  def initialize
    @yes = nil
    @no = nil
    @leaf = false
    @question = String.new
  end

  def ask
    puts @question
  end
end


animal_tree = YAML.load(File.read('animals.yml')) if File.exists?('animals.yml')

puts 'Think of an animal...'
while true
  answer = gets.chomp
  break if answer == 'n'
end
