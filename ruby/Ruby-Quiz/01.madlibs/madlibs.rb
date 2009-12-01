# CGI version to play with: http://rubyquiz.com/cgi-bin/madlib.cgi
class Madlibs

  def initialize(filepath)
    @madlib = File.read(filepath)
    @words = @madlib.scan(/\(\([^(\)\))]+\)\)/)
    @words_repeated = @words.map { |m| m[2..-3] }.select { |s| s =~ /.+:.+/ }.map { | m | m.split(":")[0] }
  end

  def ask
    
    @words.reject { |r| @words_repeated.include?(r[2..-3]) }.each do |w|
      multiple = false
      
      if w.include?(":")
        multiple = true
        puts "Give me #{w[2..-3].split(":")[1]}."
      else
        puts "Give me #{w[2..-3]}."
      end
      
      answer = gets.chomp
      @madlib.sub!(w, answer)
      if multiple
        @madlib.gsub!("((" + w[2..-3].split(":")[0] + "))", answer)
      end
      
    end
  end

  def display
    puts @madlib
  end

end

madlib = Madlibs.new("Gift_Giving.madlib")

madlib.ask
madlib.display
