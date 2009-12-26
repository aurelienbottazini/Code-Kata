require 'rubygems'
require 'builder'

class GEDCOMParser
  @gedcom_lines

  def initialize filepath
    @gedcom_lines = File.readlines(filepath)
  end

  def to_xml
    xml_buffer = String.new
    xm = Builder::XmlMarkup.new(:target => xml_buffer,
                                :indent => 2)
    xm.gedcom do
      last_depth = -1
      @gedcom_lines.each do |l|
        splitted_line = l.chomp.split(/ +/)
        current_depth = splitted_line[0].to_i

        current_text = String.new
        if splitted_line[1].index('@')
          current_tag = splitted_line[2]
          xm.tag!(current_tag.downcase,
                  :id => splitted_line[1])
        else
          current_tag = splitted_line[1]
          splitted_line[2..splitted_line.size].each do |s|
            current_text << s + ' '
          end
          current_text.chop!
          xm.tag!(current_tag.downcase, current_text)
        end



        last_depth = current_depth
      end
    end
    xml_buffer
  end
end
