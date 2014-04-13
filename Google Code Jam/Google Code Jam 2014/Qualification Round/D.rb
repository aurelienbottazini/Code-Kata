1.upto(gets.to_i) do |case_number|
  gets.to_i
  naomis = gets.split(" ").map(&:to_f)
  kens = gets.split(" ").map(&:to_f)

  naomis = naomis.sort!
  naomis_copy = naomis.dup
  kens = kens.sort!
  kens_copy = kens.dup
  deceitful_war = 0
  war_optimally = 0

  while naomis.size > 0
    ken_scores_optimally = false
    0.upto(kens.size-1) do |i|
      if kens[i] > naomis[0]
        ken_scores_optimally = true
        kens.delete_at(i)
        break
      end
    end
    if ken_scores_optimally == false
      war_optimally += 1
    end

    naomis.shift
  end

  kens = kens_copy
  naomis = naomis_copy

  while naomis.size > 0
    if naomis.max < kens.max
      naomis.shift
      kens.pop
    else
      scored_deceitful = false
      0.upto(naomis.size-1).each do |i|

        if naomis[i] > kens[0]
          deceitful_war += 1
          kens.shift
          naomis.delete_at(i)
          scored_deceitful = true
          break
        end
      end

      if scored_deceitful == false
        kens.shift
        naomis.shift
      end

    end
  end

  puts "Case ##{case_number}: #{deceitful_war} #{war_optimally}"
end
