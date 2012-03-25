1.upto(gets.to_i) do |case_number|

  n, k = gets.split.map(&:to_i)
  number_of_snaps = 0.upto(n).reduce(0) do |sum, n|
    if n == 0
      sum = 0
    elsif n == 1
      sum = 2
    else
      sum * 2
    end
  end

  answer = 'OFF'

  k += 1
  if k >= number_of_snaps
    answer = 'ON' if (k % number_of_snaps) == 0
  end
  puts "Case ##{case_number}: #{answer}"
end
