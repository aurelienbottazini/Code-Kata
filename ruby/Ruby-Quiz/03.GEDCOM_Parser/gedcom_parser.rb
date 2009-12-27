require 'rexml/document'

class GEDCOMParser

  def initialize filepath
    @gedcom_lines = File.readlines(filepath)
  end

  def to_xml
    xml = REXML::Element.new('gedcom')

    stack = Array.new
    stack.push xml
    last_depth = 0
    @gedcom_lines.each do |l|
      splitted_line = l.chomp.split(/\s+/)

      current_depth = splitted_line[0].to_i
      while((current_depth + 1) < stack.size) do
        stack.pop
      end
      element = stack.last

      attribute = false
      if splitted_line[1].index('@')
        current_tag = splitted_line[2]
        attribute = true
      else
        current_tag = splitted_line[1]
      end
      element = element.add_element(current_tag.downcase)
      element.add_attribute('id', splitted_line[1]) if attribute
      data = splitted_line[2..splitted_line.size].map { |x| x + ' '}.to_s.chop
      element.add_text(data) unless attribute

      stack.push element
    end


    xml.to_s
  end


end
