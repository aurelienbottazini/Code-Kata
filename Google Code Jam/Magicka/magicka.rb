class Magicka
  attr_reader :number_of_non_base_elements, :combinable_elements, :number_of_opposed_elements,
  :opposed_elements, :number_of_base_elements, :base_elements

  def initialize input
    splitted_input = input.split(' ')
    @number_of_non_base_elements = splitted_input[0].to_i

    @combinable_elements = Hash.new
    1.upto(@number_of_non_base_elements).each do |number|
      combinable = splitted_input[number][0..1]
      combined = splitted_input[number][2]
      @combinable_elements[combinable] = combined

      combinable = splitted_input[number][1] + splitted_input[number][0]
      @combinable_elements[combinable] = combined
    end

    @number_of_opposed_elements = splitted_input[@number_of_non_base_elements + 1].to_i
    @opposed_elements = Array.new
    1.upto(@number_of_opposed_elements).each do |number|
      @opposed_elements << splitted_input[@number_of_non_base_elements + 1 + number]
      @opposed_elements << splitted_input[@number_of_non_base_elements + 1 + number][1] + splitted_input[@number_of_non_base_elements + 1 + number][0]
    end

    @number_of_base_elements = splitted_input[@number_of_non_base_elements + 1 + @number_of_opposed_elements + 1].to_i
    @base_elements = splitted_input.last
  end

  def resulting_elements
    index = 1
    resulting_elements = @base_elements
    while index < resulting_elements.size
      elements_duo = resulting_elements[index-1..index]
      if @combinable_elements[elements_duo]
        splitted = resulting_elements.split(elements_duo, 2)
        resulting_elements = splitted[0] + @combinable_elements[elements_duo] + splitted[1]
        index = index - 1
      end


      @opposed_elements.each do |opposed_elements|
        if resulting_elements[index] == opposed_elements[1]

          index_of_last_opposed = resulting_elements[0..index-1].index(opposed_elements[0])

          if index_of_last_opposed
            splitted = resulting_elements.split(resulting_elements[index_of_last_opposed..index], 2)
            resulting_elements = splitted[0] + splitted[1]
            index = index_of_last_opposed
          end
        end
      end
      index += 1
    end
    resulting_elements
  end

end
