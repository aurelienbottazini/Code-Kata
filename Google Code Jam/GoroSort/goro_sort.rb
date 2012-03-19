def factorial number
  result = 1
  1.upto(number) do |number|
    result = result * number
  end
  result
end

1.upto(gets.to_i) do |case_number|
  number_of_elements = gets.to_i
  elements = gets.split.map(&:to_i)

  in_order = 0
  index = 1
  elements.each do |element|
    if element == index
      in_order += 1
    end
    index += 1
  end
  solution = elements.size - in_order
  puts "Case ##{case_number}: " + '%.6f' % solution
end
