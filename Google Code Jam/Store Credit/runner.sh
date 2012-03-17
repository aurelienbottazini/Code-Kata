#!/usr/bin/env ruby
require './store_credit.rb'
lines = File.open(ARGV[0]).readlines

number_of_cases = readlines[0].to_i
lines = lines[1..lines.size]
1.upto(number_of_cases).each do |number|
  credit = lines[(number-1)*3].to_i
  number_of_elements = lines[(number-1)*3+1].to_i
  elements = lines[(number-1)*3+2].split(' ')
  elements = elements.map { |x| x.to_i}
  store = StoreCredit.new(credit, number_of_elements, elements)
  solution = store.objects_to_buy
  solution_string = String.new
  solution.each do |value|
    solution_string << "#{value} "
  end
  puts "Case ##{number}: #{solution_string.chop}"
end
