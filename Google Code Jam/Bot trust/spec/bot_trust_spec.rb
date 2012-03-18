require './bot_trust.rb'

describe BotTrust do
  subject { BotTrust.new("4 O 2 B 1 B 2 O 4")}

  its(:sequence) { should == [[1,2], [2,4], ['O', 'B', 'B', 'O']]}
  its(:number_of_buttons) { should == 4 }
  its(:do_steps) { should == 6 }
end
