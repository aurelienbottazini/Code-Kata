def time_to_get_farm_n(n, c, f)
  c / (f * (n-1) + 2)
end

def time_to_get_x_cookies(x, number_of_farms, f)
  x / (f * number_of_farms + 2)
end

def time_to_get_n_farm(number_of_farms, c, f)
  time = 0.0
  1.upto(number_of_farms) do |i|
    time = time + c / (f * (i-1) + 2)
  end
  return time
end


1.upto(gets.to_i) do |case_number|
  c, f, x = gets.split(" ").map(&:to_f)

  time_elapsed = 0.0
  number_of_farms = 0
  while time_to_get_x_cookies(x, number_of_farms, f) >
        time_to_get_farm_n(number_of_farms+1, c, f) + time_to_get_x_cookies(x, number_of_farms+1, f)
    time_elapsed = time_elapsed + time_to_get_farm_n(number_of_farms+1, c, f)
    number_of_farms = number_of_farms + 1
  end
  time_elapsed = time_elapsed + time_to_get_x_cookies(x, number_of_farms, f)

  puts "Case ##{case_number}: #{sprintf("%.7f" ,time_elapsed)}"
end
