def next_map_number map_number
  if map_number == 0
    map_number = 2
  else
    map_number += 1
  end
end
1.upto(gets.to_i) do |case_number|

  message = gets.chomp

  chars_mapping = Hash.new
  chars_mapping[message[0]] = 1

  map_number = 0
  message.each_char do |char|
    if !chars_mapping.has_key?(char)
      chars_mapping[char] = map_number
      map_number = next_map_number map_number
    end
  end
  base = chars_mapping.size
  base = 2 if base < 2
  smallest_time = 0
  index = message.size - 1
  message.each_char do |char|

    smallest_time += chars_mapping[char] * (base ** index)
    index = index - 1
  end

  puts "Case ##{case_number}: #{smallest_time}"
end
