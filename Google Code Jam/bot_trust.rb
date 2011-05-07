#!/usr/bin/env ruby
class BotTrust

  attr_reader :number_of_test_cases
  BUTTON_CLICK = 1

  def initialize sample_file_path
    @lines = File.readlines(sample_file_path)
    @test_cases = @lines[1..@lines.size]
    @number_of_test_cases = @lines[0].to_i
  end

  def get_time_required sequence
    time_required = 0
    number_of_buttons, n_terms = sequence.split(' ', 2)
    n_terms = n_terms.chomp
    n_terms = n_terms.scan(/[OB] [0-9]+/)
    simplified_n_terms = Array.new
    previous_robot = nil

    o_pos = 1
    b_pos = 1

    n_terms.each do |n_term|
      n_term_robot, n_term_position = n_term.split(' ')
      n_term_position = n_term_position.to_i
      robot_position = 0

      if n_term_robot == 'O'
        robot_position = o_pos
        o_pos = n_term_position
      else
        robot_position = b_pos
        b_pos = n_term_position
      end

      action_cost = BotTrust.time_to_move(robot_position, n_term_position)
      action_cost = action_cost + BUTTON_CLICK

      if previous_robot != n_term_robot
        simplified_n_terms << [action_cost]
      else
        simplified_n_terms[simplified_n_terms.size - 1] << action_cost
      end
      previous_robot = n_term_robot
    end

    p simplified_n_terms
    simplified_n_terms.each_with_index do |term, index|
      term_sum = term.inject(0) { |s,v| s += v }
      time_required = time_required + term_sum

      if index > 0
        if term[0] > 1
          previous_term = simplified_n_terms[index - 1]
          previous_term_sum = term.inject(0) { |s,v| s += v}

          psum = 0
          previous_term.reverse.each do |pterm|
            if (psum + pterm) < term_sum
              psum += pterm
            end
          end
          p psum
          time_required = time_required - psum
        end

      end

    end
    time_required
  end

  def self.time_to_move old_position, new_position
    (old_position - new_position).abs
  end

  # Each test case consists of a single line beginning with a positive
  # integer N, representing the number of buttons that need to be
  # pressed. This is followed by N terms of the form "Ri Pi" where Ri
  # is a robot color (always 'O' or 'B'), and Pi is a button position.
  def print_result
    times_required = Array.new
    @test_cases.each do |test_case|
      times_required << get_time_required(test_case)
    end

    times_required.each_with_index do |time, index|
      puts "Case ##{index + 1}: #{time}"
    end

  end

end

# if ARGV[0]
#   @bt = BotTrust.new(ARGV[0])
#   @bt.print_result
# end

