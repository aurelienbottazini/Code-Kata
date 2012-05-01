def debug text
  STDERR.puts text
end

1.upto(gets.to_i) do |case_number|

  a, b = gets.split.map(&:to_i)

  a_list = gets.split.map(&:to_f)

  probability_success = a_list.reduce(:*)
  keystrokes = Array.new
  #case 1
  keystrokes << b - a + 1 + (b + 1) * (1 - probability_success)
  #case 2

  x = 1.0
  1.upto(a) do |i|
    x = x * a_list[i-1]
    k = a - i
    keystrokes << b - a + 2 * k + 1 + (b + 1) * (1 - x)
  end

  #case 3
  keystrokes << b + 2

  puts "Case ##{case_number}: #{sprintf('%0.6f', keystrokes.min)}"
  debug "Solved #{case_number}"
end
