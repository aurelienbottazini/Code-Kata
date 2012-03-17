class StoreCredit
  attr_reader :credit, :number_of_available_items, :items_list

  def initialize credit, number_of_available_items, items_list
    @credit, @number_of_available_items, @items_list = credit, number_of_available_items, items_list
    @solution
    @should_stop = false
  end

  def objects_to_buy
    add_item([], @items_list)
    to_buy_index_list = Array.new

    @solution.each do |value|
      good_index = 0
      @items_list.each_with_index do |item, index|
        if item == value && !to_buy_index_list.include?(index+1)
          good_index = index+1
        end
      end
      to_buy_index_list << good_index
    end

    to_buy_index_list.sort
  end

  private

  def add_item choosed_items, remaining_items
    current_sum = choosed_items.inject(0) { |sum, x| sum+=x}
    if current_sum == @credit
      @solution = choosed_items
      @should_stop = true
    else
      remaining_items.each_with_index do |item, index|
        cloned_remaining_items = Marshal.load(Marshal.dump(remaining_items))
        cloned_remaining_items.delete_at(index)
        cloned_choosed_items = Marshal.load(Marshal.dump(choosed_items))
        cloned_choosed_items << item
        if cloned_choosed_items.size < 3
          if @should_stop == false
            add_item(cloned_choosed_items, cloned_remaining_items)
          end
        end
      end
    end
  end
end
