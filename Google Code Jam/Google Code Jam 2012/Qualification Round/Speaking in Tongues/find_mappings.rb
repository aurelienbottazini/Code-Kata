mappings = Hash.new
1.upto(gets.to_i) do |case_number|
  line = gets.chomp
  translation = gets.chomp

  0.upto(line.size-1) do |i|
    if !mappings.key?(line[i])
      mappings[line[i]] = translation[i]
    end
  end

end

mappings['z'] = 'q'
mappings['q'] = 'z'
p mappings.size
puts mappings
