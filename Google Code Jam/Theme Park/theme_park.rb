1.upto(gets.to_i) do |case_number|
  memoize = Hash.new
  r, k, n = gets.split.map(&:to_i)
  groups = gets.split.map(&:to_i)

  money = 0

  index = 0
  1.upto(r).each do

    if memoize.has_key?(index)
      values = memoize[index]
      money += values[0]
      index = values[1]
    else
      places_left = k
      money_to_add = 0
      saved_index = index
      i = 1
      loop do
        current_group = groups[index]
        if current_group <= places_left
          money_to_add += current_group
          places_left = places_left - current_group
          if index < n - 1
            index += 1
          else
            index = 0
          end
        else
          break
        end
        i += 1
        break if i == n+1
      end

      memoize[saved_index] = [money_to_add, index]
      money += money_to_add
    end
  end

  puts "Case ##{case_number}: #{money}"
end
