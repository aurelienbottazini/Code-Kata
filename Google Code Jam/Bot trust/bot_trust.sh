#!/usr/bin/env ruby
require './bot_trust.rb'
lines = File.open(ARGV[0]).readlines
number_of_cases = lines[0]

lines = lines[1..lines.size]

lines.each_with_index do |line, index|
  puts "Case ##{index+1}: " + BotTrust.new(line.chomp).do_steps.to_s
end
