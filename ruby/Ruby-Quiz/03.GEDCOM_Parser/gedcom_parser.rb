require 'rexml/document'

class GEDCOMParser

  def initialize filepath
    @gedcom_lines = File.readlines(filepath)
  end

  def to_xml
    xml_root = REXML::Element.new('gedcom')

    stack = Array.new
    stack.push xml_root
    last_depth = 0
    @gedcom_lines.each do |line|
      splitted_line = line.chomp.split(/\s+/)

      line =~ /^\s*([0-9]+)\s+(@\S+@|\S+)(\s(.*))?$/ or raise "GEDCOM not properly formatted"
      current_depth = $1.to_i
      current_tag = $2
      data = $4

      while((current_depth + 1) < stack.size) do
        stack.pop
      end
      xml_element = stack.last

      attribute = false
      if current_tag.index('@')
        current_tag = $4
        attribute = true
      end
      xml_element = xml_element.add_element(current_tag.downcase)
      xml_element.add_attribute('id', $2) if attribute
      xml_element.add_text(data) unless attribute

      stack.push xml_element
    end

    xml_root.to_s
  end
end
