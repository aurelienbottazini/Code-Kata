require 'rubygems'
require 'spec'
require 'gedcom_parser'

describe GEDCOMParser do
  
  it "should raise an argument error without a filename" do
    lambda { GEDCOMParser.new }.should raise_error(ArgumentError)
  end

  it "should raise an error with an invalid filename" do
    lambda { GEDCOMParser.new("missing.ged") }.should raise_error
  end
  
  it "should render a valid example xml" do
    gedcom = GEDCOMParser.new("example.ged")
    gedcom.to_xml.should eql File.read("example.xml")
  end
  
end
