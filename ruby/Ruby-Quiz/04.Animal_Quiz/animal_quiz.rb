#!/usr/bin/env ruby
=begin rdoc
 It works like this: The program starts by telling the user to think
 of an animal. It then begins asking a series of yes/no questions
 about that animal: Does it swim? Does it have hair? And so
 on.... Eventually, it will narrow down the possibilities to a single
 animal and guess: is it a mouse?
=end
require 'yaml'

class Question
  attr_accessor :yes
  attr_accessor :no
  attr_accessor :answer
  attr_accessor :question
  
  def initialize question = nil, answer = nil
    @yes = false
    @no = false
    @question = question
    @answer = answer
  end

  def ask?
    if @question
      puts "#{@question} (y or n)"
    else
      puts "Is it #{@answer}? (y or n)"
    end

    answer = gets.chomp
    return (answer == 'y') ? yes : no
  end

end

def play_again?

  puts "Play again?"
  answer = gets.chomp

  if answer == 'y'
    return true
  else
    return false
  end
end


root_question = nil
if File.exists?('questions.yml')
  root_question = YAML.load(File.read('questions.yml'))
else
  root_question = Question.new(nil, "elephant")
  root_question.yes = true
end

puts 'Think of an animal...'
current_question = root_question


run_loop = true
i = 0
while run_loop


  answer = current_question.ask?

  case answer
  when true
    puts 'I win. Pretty smart, aren\'t I?'

    if play_again?
      current_question = root_question
    else
      run_loop = false
    end
  when false
    puts "You win. Help me learn from my mistake before you go..."
    # we ask for the correct animal
    puts "What animal were you thinking of?"
    new_animal = gets.chomp

    print "Give me a question to distinguish #{new_animal} from "
    puts "#{current_question.answer} "
    new_animal_question = gets.chomp
    puts "For #{new_animal} what is the answer to your question? (y or n)"

    new_animal_answer = gets.chomp

    
    new_question = Question.new(nil, new_animal)
    new_question.yes = true

    old_question = Question.new(nil, current_question.answer)
    old_question.yes = true


    current_question.question = new_animal_question
    current_question.answer = nil
    
    if new_animal_answer == 'y'
      current_question.yes = new_question
      current_question.no = old_question
      
    else
      current_question.no = new_question
      current_question.yes = old_question
    end

    if play_again?
      current_question = root_question
    else
      run_loop = false
    end

    
  else # navigating in the binary tree
    current_question = answer
  end
  ++i
end

f = File.new('questions.yml', "w")
f << root_question.to_yaml
f.close

