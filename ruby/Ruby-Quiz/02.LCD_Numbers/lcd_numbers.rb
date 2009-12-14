class LCDNumbers
  attr_accessor :size

  def initialize number
    @number = number
    @size = 2
  end

  def to_s
    output = String.new

    output_array = ['','','','','']
    
    @number.to_s.each_char do |c|
      temp_array_number = Array.new
      
      case c
      when '0' then temp_array_number = zero
      when '1' then temp_array_number = one
      when '2' then temp_array_number = two
      when '3' then temp_array_number = three
      when '4' then temp_array_number = four
      when '5' then temp_array_number = five
      when '6' then temp_array_number = six
      when '7' then temp_array_number = seven
      when '8' then temp_array_number = height
      when '9' then temp_array_number = nine
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

  private

  def zero
    val = Array.new
    val << " - "
    val << "| |"
    val << "   "
    val << "| |"
    val << " - "
  end

  def one
    val = Array.new
    val << "   "
    val << "  |"
    val << "   "
    val << "  |"
    val << "   "
  end

  def two
    val = Array.new
    val << " - "
    val << "  |"
    val << " - "
    val << "|  "
    val << " - "
  end

  def three
    val = Array.new
    val << " - "
    val << "  |"
    val << " - "
    val << "  |"
    val << " - "
  end

  def four
    val = Array.new
    val << "   "
    val << "| |"
    val << " - "
    val << "  |"
    val << "   "
  end

  def five
    val = Array.new
    val << " - "
    val << "|  "
    val << " - "
    val << "  |"
    val << " - "
  end

  def six
    val = Array.new
    val << " - "
    val << "|  "
    val << " - "
    val << "| |"
    val << " - "
  end

  def seven
    val = Array.new
    val << " - "
    val << "  |"
    val << "   "
    val << "  |"
    val << "   "
  end

  def height
    val = Array.new
    val << " - "
    val << "| |"
    val << " - "
    val << "| |"
    val << " - "
  end

  def nine
    val = Array.new
    val << " - "
    val << "| |"
    val << " - "
    val << "  |"
    val << " - "
  end

end