require "lcd_numbers"

# option parsing
s=2 
if ARGV.size >= 2 and ARGV[0] == '-s' and ARGV[1] =~ /^[1-9]\d*$/
  ARGV.shift
  s = ARGV.shift.to_i
end

# digit parsing/usage
unless ARGV.size == 1 and ARGV[0] =~ /^\d+$/ 
  puts "Usage: #$0 [-s SIZE] DIGITS" 
  exit
end

lcd_number = LCDNumbers.new(ARGV[0])
lcd_number.size = s

puts lcd_number.to_s