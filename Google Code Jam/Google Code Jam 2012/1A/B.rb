def debug text
  STDERR.puts text
end

def doable_levels?
  @levels_list.each do |level|
    star_1 = level[0]
    if star_1[1] == false && star_1[0] <= @stars
      return true
    end

    star_2 = level[1]
    if star_2[1] == false && star_2[0] <= @stars
      return true
    end
  end

  return false
end

def find_2_star_level_index

  @levels_list.each_with_index do |level, index|
    star_1 = level[0]
    star_2 = level[1]

    if star_2[1] == false &&
        star_2[0] <= @stars &&
        star_1[1] == false &&
        star_1[0] <= @stars
      return index
    end
  end

  return nil
end

def star_1_level_or_highest_2star_index
  indexes = Array.new
  @levels_list.each_with_index do |l, i|
    star_1 = l[0]
    star_2 = l[1]

    if star_1[1] == true && star_2[1] == false && star_2[0] <= @stars
      return i
    end

    if star_1[1] == false && star_1[0] <= @stars
      indexes << i
    elsif star_2[1] == false && star_2[0] <= @stars
      indexes << i
    end
  end


  star_2_val = -1
  return_index = -1
  indexes.each do |i|
    if @levels_list[i][1][0] > star_2_val
      star_2_val = @levels_list[i][1][0]
      return_index = i
    end
  end

  return return_index
end

1.upto(gets.to_i) do |case_number|

  n = gets.to_i
  @levels_list = Array.new
  1.upto(n) do
    levels = gets.split.map(&:to_i)
    @levels_list << [[levels[0], false], [levels[1], false]]
  end

  @stars = 0
  @runs = 0
  while doable_levels?
    star2_level_index = find_2_star_level_index

    if star2_level_index
      @levels_list[star2_level_index][0][1] = true
      @levels_list[star2_level_index][1][1] = true
      @stars = @stars + 2
    else
      star1_level_index = star_1_level_or_highest_2star_index
      @stars = @stars + 1

      if @levels_list[star1_level_index][0][1] == false
        @levels_list[star1_level_index][0][1] = true
      else
        @levels_list[star1_level_index][1][1] = true
      end
    end
    @runs += 1
  end

  answer = @runs
  if @stars != 2*n
    answer = 'Too Bad'
  end

  puts "Case ##{case_number}: #{answer}"
  debug "Solved #{case_number}"
end
