# CGI version to play with: http://rubyquiz.com/cgi-bin/madlib.cgi
class Madlibs
  
  attr_reader :questions, :madlib
  attr_writer :answers

  def initialize(filepath)
    @madlib = File.read(filepath)
    @words = @madlib.scan(/\(\([^(\)\))]+\)\)/).map { |m| m[2..-3] }
    @words_repeated = @words.select { |s| s =~ /.+:.+/ }.map { | m | m.split(":")[0] }
    @answers = Array.new
    format_questions
  end

  def map_answers
    @words.reject { |r| @words_repeated.include?(r) }.each_with_index do |w, i| 
      @madlib.sub!("((#{w}))", @answers[i])
      if w.to_s.include?(":")
        @madlib.gsub!("((" + w.split(":")[0] + "))", @answers[i])
      end
    end
  end

  private

  def format_questions
    @questions = Array.new
    @words.reject { |r| @words_repeated.include?(r) }.each do |w|  
      something = String.new
      if w.include?(":")
        something = w.split(":")[1]
      else
        something = w
      end
      @questions << "Give me #{something}."
    end
    @questions
  end

end