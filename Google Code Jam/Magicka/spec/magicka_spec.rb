require './magicka.rb'

describe Magicka do
  context "first example" do
    subject { Magicka.new("1 EEZ 1 QE 7 QEEEERA")}
    its(:number_of_non_base_elements) { should == 1}
    its(:combinable_elements) { should == {'EE' => 'Z'}}
    its(:number_of_opposed_elements) { should == 1}
    its(:opposed_elements) { should == ['QE', 'EQ']}
    its(:number_of_base_elements) { should == 7}
    its(:base_elements) { should == 'QEEEERA'}
    its(:resulting_elements) { should == 'ZERA'}
  end

  context "second example" do
    subject { Magicka.new("1 QFT 0 2 QF")}
    its(:resulting_elements) { should == 'T'}
  end

  context "third example" do
    subject { Magicka.new("1 QFT 0 3 QEF")}
    its(:resulting_elements) { should == 'QEF'}
  end

  context "fourth example" do
    subject { Magicka.new("1 QFT 1 FR 3 REF")}
    its(:resulting_elements) { should == ''}
  end

  context "fifth example" do
    subject { Magicka.new("1 QFT 1 FR 3 RQF")}
    its(:resulting_elements) { should == 'RT'}
  end

  context "sixth example" do
    subject { Magicka.new("1 QFT 1 FR 3 RFQ")}
    its(:resulting_elements) { should == 'Q'}
  end

  context "7 example" do
    subject { Magicka.new("1 ARG 1 QF 10 ARQRSQFFSQ")}
    its(:resulting_elements) { should == 'GSQ'}
  end



end
