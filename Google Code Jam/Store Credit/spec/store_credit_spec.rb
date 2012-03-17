require './store_credit.rb'

describe StoreCredit do
  context "first example" do
    subject { StoreCredit.new(100, 3, [5, 75, 25]) }
    its(:credit) { should == 100}
    its(:number_of_available_items) { should == 3 }
    its(:items_list) { should == [5, 75, 25]}
    its(:objects_to_buy) { should == [2, 3]}
  end

  context "second example" do
    subject { StoreCredit.new(200, 7, [150, 24, 79, 50, 88, 345, 3]) }
    its(:objects_to_buy) { should == [1, 4]}
  end

  context "third example" do
    subject { StoreCredit.new(8, 8, [2, 1, 9, 4, 4, 56, 90, 3]) }
    its(:objects_to_buy) { should == [4, 5]}
  end

end
