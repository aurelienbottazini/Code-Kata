require 'spec_helper'
require 'bot_trust'

describe BotTrust do

  before(:each) do
    @bt = BotTrust.new("#{DATA_DIR}/bot_trust_sample.txt")
  end


  it "should initialize" do
  end

  it "should get the correct result for sample" do
    @bt.find_sequence

    open("#{TMP_DIR}/bot_trust_generated.txt", 'r:utf-8') do |generated_file|
      open("#{DATA_DIR}/bot_trust_result.txt", 'r:utf-8') do |test_file|
        generated_file.read.should eql test_file.read
      end
    end
  end

end



