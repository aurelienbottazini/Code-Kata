#!/usr/bin/env ruby

mapping = {
  ' ' => '0',
  0 => ' ',
  'a' => '2',
  'b' => '22',
  'c' => '222',
  'd' => '3',
  'e' => '33',
  'f' => '333',
  'g' => '4',
  'h' => '44',
  'i' => '444',
  'j' => '5',
  'k' => '55',
  'l' => '555',
  'm' => '6',
  'n' => '66',
  'o' => '666',
  'p' => '7',
  'q' => '77',
  'r' => '777',
  's' => '7777',
  't' => '8',
  'u' => '88',
  'v' => '888',
  'w' => '9',
  'x' => '99',
  'y' => '999',
  'z' => '9999'
}



lines = File.open(ARGV[0]).readlines
number_of_cases = lines[0]

lines = lines[1..lines.size]

lines.each_with_index do |line, index|
  translated_line = String.new
  @last_number = -1
  line.chomp.each_char do |char|
    if @last_number == mapping[char][0]
      translated_line << ' '
    end
    translated_line << mapping[char]

    @last_number = mapping[char][0]
  end
  puts "Case ##{index+1}: " + translated_line
end
