#!/usr/bin/env ruby
require 'yaml'

# It works like this: The program starts by telling the user to think
# of an animal. It then begins asking a series of yes/no questions
# about that animal: Does it swim? Does it have hair? And so
# on.... Eventually, it will narrow down the possibilities to a single
# animal and guess: is it a mouse?
class Question
  attr_writer :yes
  attr_writer :no
  attr_reader :yes
  attr_reader :no
  attr_reader :answer

  def initialize answer, question = nil, parent = nil
    @yes = false
    @no = false
    @answer = answer
    @question = question
    @parent = parent
  end

  def ask?
    if @question
      puts @question + " (y or n)"
      answer = gets.chomp
      answer_node = (answer == 'y') ? yes : no
      if answer_node
        puts "Is it #{@answer}? (y or n)"
      else
        puts "Is is #{@parent.answer}? (y or n)"
      end
    else
      puts "Is it #{@answer}? (y or n)"
    end
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
  root_question = Question.new("an elephant")
  root_question.yes = true
end

puts 'Think of an animal...'
current_question = root_question


run_loop = true
while run_loop
  current_question.ask?
  answer = gets.chomp

  answer = (answer == 'y') ? current_question.yes : current_question.no

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
    new_question = gets.chomp
    puts "For a #{new_animal} what is the answer to your question? (y or n)"

    new_animal_answer = gets.chomp

    new_question_node = Question.new(new_animal, new_question, current_question)

    if new_animal_answer == 'y'
      new_question_node.yes = true
      current_question.no = new_question_node
    else
      new_question_node.no = true
      current_question.yes = new_question_node
    end

    if play_again?
      current_question = root_question
    else
      run_loop = false
    end
  else
    current_question = answer
  end
end

f = File.new('questions.yml', "w")
f << root_question.to_yaml
f.close

