1.upto(gets.to_i) do |case_number|

  n, pd, pg = gets.split.map(&:to_i)

  answer = 'Possible'
  if pg == 100 && pd != 100
    answer = 'Broken'
  end

  if pd != 0 && pg == 0
    answer = 'Broken'
  end

  if n == 0 && pd > 0
    answer == 'Broken'
  end


  if answer == 'Possible'
    integer_possible = false
    1.upto(n) do |d|
      saved_d = d
      d = d * pd / 100.0
      if d.round == d
        integer_possible = true
        break
      end
    end

    if integer_possible == false
      answer = 'Broken'
    end
  end

  puts "Case ##{case_number}: #{answer}"
end
