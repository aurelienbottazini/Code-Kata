def gcd(a, b)
  if b == 0
    return a
  end
  return gcd(b, a % b)
end

1.upto(gets.to_i) do |case_number|
  n, *t = gets.chomp.split(" ").map(&:to_i)

  t.sort!
  smallest = t[0]

  g = nil
  t.map! { |x|  x - smallest}

  0.upto(n-1).each do |i|
    if g == nil
      g = t[i]
    else
      g = gcd(g, t[i])
    end

  end

  answer = smallest%g
  answer = g - answer if answer > 0

  puts "Case ##{case_number}: #{answer}"
end
