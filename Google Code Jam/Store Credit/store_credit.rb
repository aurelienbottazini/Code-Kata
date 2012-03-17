class StoreCredit
  attr_reader :credit, :number_of_available_items, :items_list

  def initialize credit, number_of_available_items, items_list
    @credit, @number_of_available_items, @items_list = credit, number_of_available_items, items_list
    @solution
  end

  def objects_to_buy
    add_item([], @items_list)
    to_buy_index_list = Array.new
    @solution.each do |value|
      to_buy_index_list << value[1] + 1
    end

    to_buy_index_list.sort
  end

  private

  def add_item choosed_items, remaining_items
    current_sum = choosed_items.inject(0) { |sum, x| sum+=x[0]}
    if current_sum == @credit
      @solution = choosed_items
    else
      remaining_items.each_with_index do |item, index|
        cloned_remaining_items = Marshal.load(Marshal.dump(remaining_items))
        cloned_remaining_items.delete_at(index)
        cloned_choosed_items = Marshal.load(Marshal.dump(choosed_items))
        cloned_choosed_items << [item, index]
        if cloned_choosed_items.size < 3
          add_item(cloned_choosed_items, cloned_remaining_items)
        end
      end
    end
  end
end
