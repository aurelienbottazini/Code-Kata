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
    b_position = 1

    n_terms.each do |n_term|
      n_term_robot, n_term_position = n_term.split(' ')
      n_term_position = n_term_position.to_i

      current_position = n_term_robot == 'O' ? o_position : b_position
      if current_position != n_term_position

      end

    end

    time_required
  end

  def self.time_to_move_and_push_button old_position, new_position
    (old_position - new_position).abs + 1
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
