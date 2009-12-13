require 'rubygems'
require 'spec'
require 'lcd_numbers'

describe LCDNumbers do
  
  it "should raise an argument error " do
    lambda { LCDNumbers.new }.should raise_error(ArgumentError)
  end
  
  it "should have a size of 2 by default" do
    LCDNumbers.new(1).size.should eql 2
  end
  
  it "should correctly display 012345" do
    LCDNumbers.new(012345).to_s.should eql " --	-- --	-- ||||||||
    | | | --| --||--||-- |||||||
    |--| ||----| |--|"
  end
  
  it "should correctly display 6789 with a size of 1" do
    lcd_numbers = LCDNumbers.new(6789)
    lcd_numbers.size = 1
    lcd_numbers.to_s.should eql " ---- |-	| |-| |-|
    |-| ||-|-|"
  end
  
end