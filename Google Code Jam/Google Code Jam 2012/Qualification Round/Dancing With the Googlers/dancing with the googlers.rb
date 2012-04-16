1.upto(gets.to_i) do |case_number|

  line = gets.chomp
  numbers = line.split.map(&:to_i)

  n = numbers[0]
  s = numbers[1]
  p = numbers[2]
  t = numbers[3..n+2]

  possible = 0
  googlers = 0
  0.upto(n-1) do |i|
    starting_triplet_value = t[i] / 3
    starting_triplet_rem = t[i] % 3

    if starting_triplet_value >= p
      googlers += 1
    elsif starting_triplet_value == p - 1
      if starting_triplet_rem == 0
        if starting_triplet_value != 0
          possible += 1
        end
      else
        googlers += 1
      end
    elsif starting_triplet_value == p - 2
      if starting_triplet_rem == 2
        possible += 1
      end
    end
  end

  if possible >= s
    answer = s
  else
    answer = possible
  end

  answer += googlers
  puts "Case ##{case_number}: #{answer}"
end
