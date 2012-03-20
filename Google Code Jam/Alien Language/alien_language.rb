l, d, n = gets.split.map(&:to_i)

words = Array.new
1.upto(d).each do |word|
  words << gets.chomp
end

1.upto(n).each do |case_number|
  pattern = gets

  tokens = pattern.scan(/\(?[a-z]+\)?/)

  possible_words = Array.new
  tokens.each do |token|
    expanded_token = Array.new
    if token =~ /^[a-z]+$/
      expanded_token << token
    else
      token[1..-2].each_char do |char|
        expanded_token << char
      end
    end

    if possible_words.size == 0
      possible_words = expanded_token
    else
      new_possible_words = Array.new
      possible_words.each do |word|
        expanded_token.each do |t|
          new_possible_words << word + t
        end
      end
      possible_words = new_possible_words
    end

  end

  matching_words = 0
  words.each do |word|
    if possible_words.include?(word)
      matching_words += 1
    end
  end
  puts "Case ##{case_number}: #{matching_words}"
end
