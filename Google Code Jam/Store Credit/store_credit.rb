class StoreCredit
  attr_reader :credit, :number_of_available_items, :items_list

  def initialize credit, number_of_available_items, items_list
    @credit, @number_of_available_items, @items_list = credit, number_of_available_items, items_list
    @solution
    @should_stop = false
  end

  def objects_to_buy
    item_list_copy = Marshal.load( Marshal.dump(@items_list ) )
    @items_list.each_with_index do |item, index|
      item_list_copy.each_with_index do |copy_item, copy_index|
        if index != copy_index && (item + copy_item) == @credit
          return [index+1, copy_index+1].sort
        end
      end
    end
  end

end
