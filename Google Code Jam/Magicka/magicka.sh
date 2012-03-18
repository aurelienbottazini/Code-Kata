#!/usr/bin/env ruby
require './magicka.rb'

lines = File.open(ARGV[0]).readlines
number_of_cases = lines[0]

lines = lines[1..lines.size]

lines.each_with_index do |line, index|
  elements = Magicka.new(line.chomp).resulting_elements
  printable_solution = '['
  elements.each_char do |char|
    printable_solution << "#{char}, "
  end
  if printable_solution.size > 1
    printable_solution.chop!.chop!
  end
  printable_solution << ']'
  puts "Case ##{index+1}: " + printable_solution
end
