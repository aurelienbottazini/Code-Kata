def debug text
  STDERR.puts text
end

1.upto(gets.to_i) do |case_number|



  puts "Case ##{case_number}:"
  debug "Solved #{case_number}"
end
