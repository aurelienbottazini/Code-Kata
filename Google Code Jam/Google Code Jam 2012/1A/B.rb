def debug text
  STDERR.puts text
end

def doable_levels ll
  levels = ll.select { |l| (l[0][0] <= @stars && l[0][1] == false) || l[1][0] <= @stars && l[1][1] == false}
  return levels
end

def find_2star_level_index ll
  ll.each_with_index do |l, index|
    if l[1][0] <= @stars && l[1][1] == false
      return index
    end
  end
  return nil
end

def find_1star_level_index ll
  ll.each_with_index do |l, index|
    if l[0][0] <= @stars && l[0][1] == false
      return index
    end
  end
  return nil
end

def complete_level index, star_mode

  if star_mode == 1
    @stars += 1
    @levels_list[index][0][1] = true
  else
    first_star_status = @levels_list[index][0][1]
    if first_star_status == true
      @stars += 1
    else
      @stars += 2
    end

    @levels_list.delete_at(index)
  end

  @runs += 1
end


1.upto(gets.to_i) do |case_number|
  @runs = 0

  n = gets.to_i
  @levels_list = Array.new
  1.upto(n) do
    levels = gets.split.map(&:to_i)
    @levels_list << [[levels[0], false], [levels[1], false]]
  end

  @stars = 0
  possible_levels = doable_levels @levels_list

  while possible_levels.size > 0

  # if find 2 star level do it
    level_index = find_2star_level_index(possible_levels)
    if level_index
      complete_level(level_index, 2)
    else  # else do 1 star level
      level_index = find_1star_level_index(possible_levels)
      complete_level(level_index, 1)
    end

    possible_levels = doable_levels @levels_list
  end

  answer = 'Too Bad'

  if doable_levels(@levels_list).size == 0 && @runs != 0
    answer = @runs
  end

  puts "Case ##{case_number}: #{answer}"
  debug "Solved #{case_number}"
end
