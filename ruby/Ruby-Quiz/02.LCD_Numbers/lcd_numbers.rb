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
      temp_array_number = Array.new
      
      integer =  c.to_i             
      0.upto(4).each do |i|
        temp_array_number[i] = NUMBERS[i][integer]
      end
      
      temp_array_number.map! do |row|
        row = row[0..0] + row[1..1] * @size + row[2..2]
      end
      
      temp_array_number.each_with_index do |e, i|
        output_array[i] += e
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