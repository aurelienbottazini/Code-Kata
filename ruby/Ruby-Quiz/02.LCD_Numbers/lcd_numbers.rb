class LCDNumbers
  attr_accessor :size

  def initialize number
    @number = number
    @size = 2
  end

  def to_s
    output = String.new

    output_array = Array.new
    output_array[0] = ""
    output_array[1] = ""
    output_array[2] = ""
    output_array[3] = ""
    output_array[4] = ""
    
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
      
      output_array[0] += temp_array_number[0]
      output_array[1] += temp_array_number[1]
      output_array[2] += temp_array_number[2]
      output_array[3] += temp_array_number[3]
      output_array[4] += temp_array_number[4]
    end
    
    
    output_array.each do |row|
      output << row + "\n"
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
    val
  end

  def one
    val = Array.new
    val << "   "
    val << "  |"
    val << "   "
    val << "  |"
    val << "   "
    val
  end

  def two
    val = Array.new
    val << " - "
    val << "  |"
    val << " - "
    val << "|  "
    val << " - "
    val
  end

  def three
    val = Array.new
    val << " - "
    val << "  |"
    val << " - "
    val << "  |"
    val << " - "
    val
  end

  def four
    val = Array.new
    val << "   "
    val << "| |"
    val << " - "
    val << "  |"
    val << "   "
    val
  end

  def five
    val = Array.new
    val << " - "
    val << "|  "
    val << " - "
    val << "  |"
    val << " - "
    val
  end

  def six
    val = Array.new
    val << " - "
    val << "|  "
    val << " - "
    val << "| |"
    val << " _ "
    val
  end

  def seven
    val = Array.new
    val << " - "
    val << "  |"
    val << "   "
    val << "  |"
    val << "   "
    val
  end

  def height
    val = Array.new
    val << " - "
    val << "| |"
    val << " - "
    val << "| |"
    val << " - "
    val
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