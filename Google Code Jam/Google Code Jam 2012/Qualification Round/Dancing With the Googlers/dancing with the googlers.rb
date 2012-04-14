1.upto(gets.to_i) do |case_number|

  line = gets.chomp
  numbers = line.split.map(&:to_i)

  n = numbers[0]
  s = numbers[1]
  p = numbers[2]
  t = numbers[3..n+2]

  surprising_for_sure = 0
  googlers = 0
  possibly_surprising = 0
  0.upto(n-1) do |i|
    starting_triplet_value = t[i] / 3
    starting_triplet_rem = t[i] % 3

    if starting_triplet_value >= p
      googlers += 1
      possibly_surprising += 1
    elsif starting_triplet_value == p - 1 && starting_triplet_value != 0
      if starting_triplet_rem == 0
        surprising_for_sure += 1
        googlers += 1
      else
        googlers += 1
      end
    elsif starting_triplet_value == p - 2
      if starting_triplet_rem == 2
        surprising_for_sure += 1
        googlers += 1
      end
    end
  end

  surprising = s - surprising_for_sure
  if surprising > 0
    surprising = surprising - possibly_surprising
  end

  if surprising < 0
    surprising = 0
  end


#TODO not correct need to include possibly surprising
  answer = googlers - surprising
  puts "Case ##{case_number}: #{answer}"
end
