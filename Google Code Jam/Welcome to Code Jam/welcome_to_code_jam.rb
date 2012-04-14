pattern = '$welcome to code jam'

1.upto(gets.to_i) do |case_number|
  counts = [1] + [0] * (pattern.length - 1)
  gets.chomp.each_char do |char|
    new_counts = []
    counts.each_with_index do |old_count, index|
      new_counts[index] = (old_count + ((char == pattern[index, 1]) ?
          counts[index - 1] : 0))
    end
    p new_counts
    counts = new_counts
  end
  p counts
  answer = counts.last.to_s
  if answer.length > 4
    answer = answer[-4..-1]
  end
  puts "Case ##{case_number}: #{'0' * (4 - answer.length) + answer}"
end
