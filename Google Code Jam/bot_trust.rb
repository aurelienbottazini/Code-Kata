class BotTrust

  attr_reader :number_of_test_cases

  def initialize sample_file_path
    @lines = File.readlines(sample_file_path)
    @test_cases = @lines[1..@lines.size]
    @number_of_test_cases = @lines[0].to_i
  end

  def get_time_required sequence

    number_of_buttons, n_terms = sequence.split(' ', 2)
    n_terms = n_terms.chomp
    n_terms = n_terms.scan(/[OB] [0-9]+/)

    o_position = 1
    robot_time_cumul = 0
    b_position = 1
    time_required = 0
    previous_robot = nil
    n_terms.each do |n_term|
      n_term_robot, n_term_position = n_term.split(' ')
      n_term_position = n_term_position.to_i

      current_position = n_term_robot == 'O' ? o_position : b_position
      time_to_move = BotTrust.time_to_move(n_term_position, current_position)
      current_position = n_term_position
      if n_term_robot == 'O'
        o_position = current_position
      else
        b_position = current_position
      end

      if n_term_robot != previous_robot && previous_robot != nil
        if robot_time_cumul > time_to_move
          time_required = time_required + robot_time_cumul
        else
          time_required = time_required + time_to_move + 1
        end
        robot_time_cumul = 0
      else
        robot_time_cumul = robot_time_cumul + time_to_move + 1
      end

      previous_robot = n_term_robot
    end
    time_required = time_required + robot_time_cumul

    time_required
  end

  def self.time_to_move old_position, new_position
    (old_position - new_position).abs
  end

  # Each test case consists of a single line beginning with a positive
  # integer N, representing the number of buttons that need to be
  # pressed. This is followed by N terms of the form "Ri Pi" where Ri
  # is a robot color (always 'O' or 'B'), and Pi is a button position.
  def find_sequence
    times_required = Array.new
    @test_cases.each do |test_case|
      times_required << get_time_required(test_case)
    end

    times_required.each_with_index do |time, index|
      puts "Case ##{index + 1}: #{time}"
    end

  end




end
