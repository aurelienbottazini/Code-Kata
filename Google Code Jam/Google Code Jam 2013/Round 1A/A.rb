def debug text
  STDERR.puts text
end

1.upto(gets.to_i) do |case_number|

  initial_radius, paint_ml = gets.split(' ').map(&:to_i)

  low = 1
  high = paint_ml
  number_of_rings = 0
  while low <= high
    mid = (low + high) / 2
    if (2 * initial_radius + 2 * mid - 1) * mid > paint_ml
      high = mid - 1
    else
      low = mid + 1
      number_of_rings = mid
    end
  end

  puts "Case ##{case_number}: #{number_of_rings}"
  debug "Solved #{case_number}"
end
