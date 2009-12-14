class LCDNumbers
  attr_accessor :size

  NUMBERS = [
    [" - ","   "," - "," - ","   "," - "," - "," - "," - "," - "],
    ["| |","  |","  |","  |","| |","|  ","|  ","  |","| |","| |"],
    ["   ","   "," - "," - "," - "," - "," - ","   "," - "," - "],
    ["| |","  |","|  ","  |","  |","  |","| |","  |","| |","  |"],
    [" - ","   "," - "," - ","   "," - "," - ","   "," - "," - "]
    ]

  def initialize number
    @number = number
    @size = 2
  end

  def to_s
    output = String.new

    output_array = ['','','','','']
    
    @number.to_s.each_char do |c|
      
      integer =  c.to_i             
      0.upto(4).each do |i|
        output_array[i] += NUMBERS[i][integer][0..0] + NUMBERS[i][integer][1..1] * @size + NUMBERS[i][integer][2..2]
      end
    end
    
    output_array.each do |row|
      if row.include? "|"
        @size.times do
          output << row + "\n"
        end
      else
        output << row + "\n"    
      end
    end
    
    output
  end
end