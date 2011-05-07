class BotTrust

  attr_reader :number_of_test_cases

  def initialize sample_file_path
    @lines = File.readlines(sample_file_path)
    @test_cases = @lines[1..@lines.size]
    @number_of_test_cases = @lines[0].to_i
  end

  def get_time_required o_buttons, b_buttons
    time_required = 0
    o_button = o_buttons.size > 0 ? o_buttons.shift : 0
    b_button = b_buttons.size > 0 ? b_buttons.shift : 0
    current_button = nil
    last_button_type = nil
    running = true
    while(running)
      if o_button < b_button
        if current_button != "b#{b_button}"
          time_required = time_required + b_button
          current_button = "b#{b_button}"
          if last_button_type == 'b'
            time_required = time_required + 1
          end
          last_button_type = 'b'
        end
        o_button = o_buttons.size > 0 ? o_buttons.shift : 0
      else
        if current_button != "o#{o_button}"
          time_required = time_required + o_button
          current_button = "o#{o_button}"
          if last_button_type == 'o'
            time_required = time_required + 1
          end
          last_button_type = 'o'
        end
        b_button = b_buttons.size > 0 ? b_buttons.shift : 0
      end

      if b_buttons.size + o_buttons.size <= 1
        running = false
      end
    end

    b_buttons.each do |b_button|
      time_required = time_required + b_button
    end
    o_buttons.each do |o_button|
      time_required = time_required + o_button
    end

    time_required
  end


  # Each test case consists of a single line beginning with a positive
  # integer N, representing the number of buttons that need to be
  # pressed. This is followed by N terms of the form "Ri Pi" where Ri
  # is a robot color (always 'O' or 'B'), and Pi is a button position.
  def find_sequence
    times_required = Array.new
    @test_cases.each do |test_case|
      number_of_buttons, n_terms = test_case.split(' ', 2)
      n_terms = n_terms.chomp
      n_terms = n_terms.scan(/[OB] [0-9]+/)

      o_buttons = Array.new
      b_buttons = Array.new
      n_terms.each do |n_term|
        button_type, button_number = n_term.split(' ')
        if button_type == 'O'
          o_buttons << button_number.to_i
        else
          b_buttons << button_number.to_i
        end
      end
      times_required << get_time_required(o_buttons, b_buttons)
    end

    times_required.each_with_index do |time, index|
      puts "Case ##{index + 1}: #{time}"
    end

  end




end
