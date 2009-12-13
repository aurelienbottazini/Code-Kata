class LCDNumbers
  attr_accessor :size
  
  def initialize number
    @number = number
    @size = 2
  end
  
  def to_s
    output = String.new
    
    @number.to_s.each_char do |c|
      output << c + '1'
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
    val << " _ "
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