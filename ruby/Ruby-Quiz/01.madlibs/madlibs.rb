# CGI version to play with: http://rubyquiz.com/cgi-bin/madlib.cgi
class Madlibs

  def initialize(filepath)
    @madlib = File.read(filepath)
    @words = @madlib.scan(/\(\([^(\)\))]+\)\)/)
    @answers = Hash.new
  end

  def ask
    @words.each do |w|
      puts "Give me #{w[2..-3]}."
      @answers[w.to_sym] = gets
    end
  end

  def to_s
    @madlib
  end

end

madlib = Madlibs.new("Gift_Giving.madlib")

madlib.ask