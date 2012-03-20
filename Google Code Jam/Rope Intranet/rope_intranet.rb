1.upto(gets.to_i).each do |case_number|
  number_of_wires = gets.to_i
  wires = Array.new
  1.upto(number_of_wires). each do |wire_number|
    wire = gets
    wires << wire.split.map(&:to_i)
  end

  wires.sort! { |x, y| x[0] <=> y[0]}

  intersections = 0
  wires.each_with_index do |wire, index|
    below_index = 0
    if index == 0
      below_index = 0
    else
      below_index = index - 1
    end
    intersections += wires[0..below_index].find_all { |i| i[1] > wire[1]}.size
  end

  puts "Case ##{case_number}: #{intersections}"
end
