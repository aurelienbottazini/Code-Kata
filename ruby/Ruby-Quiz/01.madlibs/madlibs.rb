# CGI version to play with: http://rubyquiz.com/cgi-bin/madlib.cgi
class Madlibs

  def initialize(filepath)
    @madlib = File.read(filepath)
    @words = @madlib.scan(/\(\([^(\)\))]+\)\)/).map { |m| m[2..-3] }
    @words_repeated = @words.select { |s| s =~ /.+:.+/ }.map { | m | m.split(":")[0] }
    @answers = Hash.new
  end

  def ask
    @words.reject { |r| @words_repeated.include?(r) }.each do |w|
      
      if w.include?(":")
        puts "Give me #{w.split(":")[1]}."
      else
        puts "Give me #{w}."
      end
      
      @answers[w.to_sym] = gets.chomp
    end
  end

  def computed
    @answers.keys.each do |a|
     @madlib.sub!("((" + a.to_s + "))", @answers[a])
      if a.to_s.include?(":")
        @madlib.gsub!("((" + a.to_s.split(":")[0] + "))", @answers[a])
      end
    end
    @madlib
  end

end

madlib =  Madlibs.new("Gift_Giving.madlib")
madlib.ask
puts madlib.computed