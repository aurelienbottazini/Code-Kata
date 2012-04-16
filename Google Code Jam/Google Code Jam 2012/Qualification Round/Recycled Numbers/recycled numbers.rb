def brute_force a, b
  mem = Hash.new
  a.upto(b) do |n|
    n = n.to_s
    0.upto(n.size - 2) do |i|
      boundary = -1-i
      m = n
      0.upto(i) do
        m = m.chop
      end
      m = m.insert(0, n[boundary..-1])
      if m.to_i <= b && n < m
        mem["#{n}#{m}"] = 1
      end
    end
  end
  mem.size
end

1.upto(gets.to_i) do |case_number|

  a, b = gets.split(" ").map(&:to_i)
  answer = brute_force(a, b)
  puts "Case ##{case_number}: #{answer}"
end
