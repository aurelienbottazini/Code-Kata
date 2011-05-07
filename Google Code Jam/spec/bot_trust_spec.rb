require 'spec_helper'
require 'bot_trust'

describe BotTrust do

  before(:each) do
    @bt = BotTrust.new("#{DATA_DIR}/bot_trust_sample.txt")
  end


  it "should initialize" do
  end

  it "should get the correct number of test cases" do
    @bt.number_of_test_cases.should eql 3
  end

  it "should get the correct result for sample" do
    @bt.get_time_required('4 O 2 B 1 B 2 O 4').should eql 6
    # @bt.get_time_required([5,8], [100]).should eql 100
    # @bt.get_time_required([], [2,1]).should eql 4
  end

  it "should give a correct move and push button time" do
    BotTrust.time_to_move_and_push_button(3, 5).should eql 3
    BotTrust.time_to_move_and_push_button(3, 3).should eql 1
  end
  # it "should get the correct output" do
  #   @bt.find_sequence
  # end

end



