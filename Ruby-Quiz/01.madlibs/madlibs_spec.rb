require "madlibs"
require "rubygems"
require "spec"

describe Madlibs do

  it "shoud raise an error when initializing without a filename" do
    lambda { Madlibs.new }.should raise_error(ArgumentError)
  end

  context "testing Gift_Giving.madlib" do

    def init_madlibs
      @madlib = Madlibs.new("Gift_Giving.madlib")
    end

    it "should initialize correctly" do
      init_madlibs
    end

    it "should correctly prepare questions on initialization" do
      init_madlibs
      @madlib.questions.size.should eql 11
      @madlib.questions.first.should eql "Give me a family member."
      @madlib.questions.last.should eql "Give me a proper name."
    end

    it "should give a valid madlib given correct answers" do
      init_madlibs
      @madlib.answers = ['Aurelien', 'birthday', '42', 'ninja', 'superb', 'strong', 'jaw', 'survivor', 'North', 'rivers', 'Ippo']
      @madlib.map_answers
      @madlib.madlib.should eql "For my Aurelien's birthday present about 42 years ago,\nI got him a ninja.   Not a superb ninja or a loud one or\neven a strong ninja that runs around chasing its jaw\nand drooling on the survivor.  I got them a North, bred in China\nthousands of years ago to be the rivers of the royal family.  We\nnamed it Ippo.\n"
    end
  end


  context "testing Lunch_Hungers.madlib" do

    def init_madlibs
      @madlib = Madlibs.new("Lunch_Hungers.madlib")
    end

    it "should initialize correctly" do
      init_madlibs
    end

    it "should correctly prepare questions on initialization" do
      init_madlibs
      @madlib.questions.size.should eql 15
      @madlib.questions.first.should eql "Give me a verb, past tense."
      @madlib.questions.last.should eql "Give me a noun."
    end

    it "should give a valid madlib given correct answers" do
      init_madlibs
      @madlib.answers = ['runned', '42', 'players', 'survivors', 'river', 'being', 'rare', 'country', 'blue', 'clearly', 'miss', 'leg', 'strongly', 'threw', 'chicken']
      @madlib.map_answers
      @madlib.madlib.should eql "I runned to the sandwich shop across the street for lunch\nyesterday. I go there at least 42 times a week. They have the best\nPhilly Cheesesteak, full of players and survivors and gooey,\nstringy river. They prepare it just right, being it\nuntil the meat breaks up and browns, but is still rare and juicy.\nThen they add special country and place two pieces of delicious blue provolone cheese on top of the meat. As soon as it melts, they scoop the\nwhole thing up and plop it on a clearly toasted bun.  The juice miss into the bread and runs down your leg when you bite\ninto it. Perfect! My mouth was watering just thinking about it. I strongly\nplaced my order, dreaming of my Cheesesteak sandwich. As soon as it was ready, I\nthrew back to my office and settled down to savor every mouth\nwatering bite.  But, wouldn't you know, they'd given me a chicken on rye\ninstead!\n"
    end

  end


end