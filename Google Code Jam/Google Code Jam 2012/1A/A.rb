def debug text
  STDERR.puts text
end

def initial_probabilites list_of_proba
  cases = [[list_of_proba[0], []], [1.0 - list_of_proba[0], [0]]]

  list_of_proba[1..list_of_proba.size].each_with_index do |proba, index|
    new_cases = Array.new
    cases.each do |c|
      new_cases << [c[0] * proba, c[1]]

      incorrects = Marshal.load(Marshal.dump(c[1]))
      incorrects << (index + 1)
      new_cases << [c[0] * (1.0 - proba), incorrects]
    end
    cases = new_cases
  end
  return cases
end

def number_of_keystrokes cases
  keystrokes = Hash.new
  keystrokes["no_errors"] = Array.new
  keystrokes["giveup_enter"] = Array.new

  if @a > 0
    1.upto(@a) do |i|
      keystrokes["backspace#{i}"] = Array.new
    end
  end

  cases.each do |c|

    # I keep typing
    #no errors when i keep typing
    keystroke = 0
    if c[1].size == 0
      keystroke = @b - @a + 1
    else
      keystroke = @b - @a + 1 + @b + 1
    end
    keystrokes["no_errors"] << [c[0], keystroke]

    # I press backspace 1 to a possible times
    if @a > 0
      1.upto(@a) do |i|

        letters_typed =  @a - i - 1
        wrong_present = false
        c[1].each do |wrong_letter_index|
          if wrong_letter_index <= letters_typed
            wrong_present = true
          end
        end

        #if no more wrong letters
        if !wrong_present
          keystroke = i + @b - @a + i + 1
        else #wrong letters still present
          keystroke = i + @b - @a + 1 + i + @b + 1
        end
        keystrokes["backspace#{i}"] << [c[0], keystroke]
      end
    end

    # i press enter and start againg
    keystroke = 1 + @b + 1
    keystrokes["giveup_enter"] << [c[0], keystroke]

  end
  return keystrokes
end

1.upto(gets.to_i) do |case_number|

  @a, @b = gets.split.map(&:to_i)

  a_list = gets.split.map(&:to_f)


  #compute the initial probabilitie cases
  cases = initial_probabilites(a_list)
  #number of keystrokes needed for each cases
  keystrokes = number_of_keystrokes(cases)

  #find the minimum number of keystrokes in table

  keystrokes_table = Array.new

  keystrokes.each do |keystroke|
    expected = 0
    keystroke[1].each do |k|
      expected = expected + k[0] * k[1]
    end
    keystrokes_table << expected
  end

  answer = keystrokes_table[0]
  keystrokes_table.each do |k|
    if answer > k
      answer = k
    end
  end

  #format answer
  p keystrokes_table
  puts "Case ##{case_number}: #{sprintf('%0.6f' ,answer)}"
  debug "Solved #{case_number}"
end
