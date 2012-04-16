
def brute_force a, b
  number_of_cases = 0
  a.upto(b) do |n|
    if n > 9
      n = n.to_s
      0.upto(n.size - 2) do |i|
        boundary = -1-i
        m = n
        0.upto(i) do
          m = m.chop
        end
        m = m.insert(0, n[boundary..-1])
        if m.to_i <= b && n < m
          number_of_cases += 1

          if @mem.key?("#{n}#{m}")
            @mem["#{n}#{m}"] += 1
          else
            @mem["#{n}#{m}"] = 1
          end
          # if mem["#{n}#{m}".to_i] == 2
          #   p "n: #{n} m:#{m}"
          # end
        end
      end
    end
  end

  number_of_cases
end

1.upto(gets.to_i) do |case_number|

  a, b = gets.split(" ").map(&:to_i)
  @mem = Hash.new
  answer = brute_force(a, b)
  #p @mem
  puts "Case ##{case_number}: #{@mem.size}"
end
