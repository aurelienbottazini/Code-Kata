require 'rubygems'
require 'spec'
require 'lcd_numbers'

describe LCDNumbers do
  
  it "should raise an argument error " do
    lambda { LCDNumbers.new }.should raise_error(ArgumentError)
  end
  
  it "should have a default size of 2" do
    LCDNumbers.new(1).size.should eql 2
  end
  
  it "should correctly display 1234567890" do
    LCDNumbers.new(1234567890).to_s.should eql "     --  --      --  --  --  --  --  -- \n   |   |   ||  ||   |      ||  ||  ||  |\n   |   |   ||  ||   |      ||  ||  ||  |\n     --  --  --  --  --      --  --     \n   ||      |   |   ||  |   ||  |   ||  |\n   ||      |   |   ||  |   ||  |   ||  |\n     --  --      --  --      --  --  -- \n"
  end
  
  it "should correctly display 6789 with a size of 1" do
    lcd_numbers = LCDNumbers.new(6789)
    lcd_numbers.size = 1
    lcd_numbers.to_s.should eql " -  -  -  - \n|    || || |\n -     -  - \n| |  || |  |\n -     -  - \n"
  end
  
end