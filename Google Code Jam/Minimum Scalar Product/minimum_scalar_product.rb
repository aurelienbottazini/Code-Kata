def opposite_sign? first, second
  if (first > 0 && second < 0) || (first < 0 && second > 0)
    true
  else
    false
  end
end

number_of_permutation = 0
1.upto(gets.to_i) do |case_number|
  vectors = Array.new
  n = gets.to_i
  first_vector = gets.split.map(&:to_i)
  second_vector =  gets.split.map(&:to_i)

  sorted_first = first_vector.sort
  sorted_second = second_vector.sort.reverse

  scalar_product = 0
  index = 0
  while index < n
    scalar_product += sorted_first[index] * sorted_second[index]
    index += 1
  end

  puts "Case ##{case_number}: #{scalar_product}"
end
