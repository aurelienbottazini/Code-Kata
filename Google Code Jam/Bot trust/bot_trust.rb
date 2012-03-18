class BotTrust
  attr_reader :number_of_buttons

  def initialize input
    @blue_pos = 1
    @orange_pos = 1
    @time = 0
    @input = input
    @number_of_buttons = @input.match(/[0-9]+/)[0].to_i
    @blue_steps, @orange_steps, @robot_turns = sequence

  end

  def sequence
    b_input = @input.scan(/B [0-9]+/)
    o_input = @input.scan(/O [0-9]+/)
    robot_turns = @input.scan(/[BO]/)
    [b_input.map { |e| e.split(' ')[1].to_i}, o_input.map { |e| e.split(' ')[1].to_i}, robot_turns]
  end

  def do_steps
    b_step, o_step = @blue_steps.shift, @orange_steps.shift
    robot_turn = @robot_turns.shift
    buttons_pushed = 0

    while buttons_pushed < @number_of_buttons
      button_pushed = nil
      if b_step != nil && b_step != @blue_pos
        @blue_pos = move_toward_button(@blue_pos, b_step)
      else
        if robot_turn == 'B'
          button_pushed = true
          b_step = @blue_steps.shift
        end
      end

      if o_step != nil && o_step != @orange_pos
        @orange_pos = move_toward_button(@orange_pos, o_step)
      else
        if robot_turn == 'O'
          button_pushed = true
          o_step = @orange_steps.shift
        end
      end

      if button_pushed
        robot_turn = @robot_turns.shift
        buttons_pushed += 1
      end

      @time = @time + 1
    end


    @time
  end

  private

  def move_toward_button current_position, button_position
    if current_position > button_position
      current_position = current_position - 1
    elsif current_position < button_position
      current_position = current_position + 1
    else
      current_position
    end
  end

end
