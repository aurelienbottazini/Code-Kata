l, d, n = gets.split.map(&:to_i)

words = Array.new
1.upto(d).each do |word|
  words << gets.chomp
end

1.upto(n).each do |case_number|
  pattern = gets
  tokens = pattern.scan(/\(?[a-z]+\)?/)

  p tokens

  matching_words = 0
  words.each do |word|
    matching = true
    word.each_char do |char|
      end
    end
  end







  puts "Case ##{case_number}: #{}"
end
