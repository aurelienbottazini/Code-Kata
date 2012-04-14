mappings = {"e"=>"o", "j"=>"u", "p"=>"r", " "=>" ", "m"=>"l", "y"=>"a", "s"=>"n", "l"=>"g", "c"=>"e", "k"=>"i", "d"=>"s", "x"=>"m", "v"=>"p", "n"=>"b", "r"=>"t", "i"=>"d", "b"=>"h", "t"=>"w", "a"=>"y", "h"=>"x", "w"=>"f", "f"=>"c", "o"=>"k", "u"=>"j", "g"=>"v", "z"=>"q", "q"=>"z"}

1.upto(gets.to_i) do |case_number|

  line = gets.chomp
  answer = String.new
  line.each_char do |char|
    answer << mappings[char]
  end
  puts "Case ##{case_number}: #{answer}"

end
