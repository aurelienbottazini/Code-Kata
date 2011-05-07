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
    @bt.get_time_required('3 O 5 O 8 B 100').should eql 100
    @bt.get_time_required('2 B 2 B 1').should eql 4
    @bt.get_time_required('10 B 1 B 1 B 1 B 1 O 1 B 1 O 1 O 1 B 1 B 1').should eql 10
    @bt.get_time_required('10 O 26 B 28 O 60 B 62 O 37 B 41 B 13 O 7 B 28 O 21').should eql 154
  end

  it "should give a correct move time" do
    BotTrust.time_to_move(3, 5).should eql 2
    BotTrust.time_to_move(3, 3).should eql 0
    BotTrust.time_to_move(2, 1).should eql 1
  end

end



