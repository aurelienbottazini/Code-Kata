require 'rubygems'
require 'spec'
require 'gedcom_parser'

describe GEDCOMParser do
  
  it "should raise an argument error without a filename" do
    lambda { GEDCOMParser.new }.should raise_error(ArgumentError)
  end
  
  it "should render a valid example xml" do
    gedcom = GEDCOMParser.new("example.ged")
    gedcom.to_xml.should eql '<gedcom>
    <indi id="@I1@">
    <name> 
      Jamis Gordon /Buck/ 
      <surn>Buck</surn>
      <givn>Jamis Gordon</givn>
    </name> 
    <sex>M</sex>
    </indi>
    </gedcom>'
  end
  
end