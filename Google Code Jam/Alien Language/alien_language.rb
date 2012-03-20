l, d, n = gets.split.map(&:to_i)

words = Array.new
1.upto(d).each do |word|
  words << gets.chomp
end

1.upto(n).each do |case_number|
  pattern = gets
  tokens = pattern.scan(/\(?[a-z]+\)?/)

  new_tokens = Array.new
  tokens.each do |token|
    if token =~ /^\(/
      token = token[1..-2]
      new_tokens << token.scan(/./)
    else
      token.each_char do |char|
        new_tokens << [char]
      end
    end
  end

  matching_words = 0
  words.each do |word|
    matching = true
    index = 0
    word.each_char do |char|
      if !new_tokens[index].include?(char)
        matching = false
        break
      end
      index +=1
    end

    if matching == true
      matching_words += 1
    end
  end








  puts "Case ##{case_number}: #{matching_words}"
end
