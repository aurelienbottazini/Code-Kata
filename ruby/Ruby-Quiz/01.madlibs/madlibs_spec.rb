require "madlibs"

describe Madlibs do
  
  it "shoud raise an error when initializing without a filename" do
    lambda { Madlibs.new }.should raise_error(ArgumentError)
  end
  
  it "should initialize correctly with a valid madlib file" do
    Madlibs.new("Gift_Giving.madlib")
  end
  
  it "should correctly ask for answers" do
    Madlibs.new("Gift_Giving.madlib").ask
  end
  
end