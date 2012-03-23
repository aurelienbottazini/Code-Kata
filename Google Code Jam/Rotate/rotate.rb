def set_result color, matching
  @blue = true if color == 'B' && matching == @k-1
  @red = true if color == 'R' && matching == @k-1
end

def test_position x, y, x_mov, y_mov, color
  return if color == 'B' && @blue == true
  return if color == 'R' && @red == true

  matching = 0
  1.upto(@k-1) do
    if @rotated_gravity_board[x+x_mov].nil? == false
      if @rotated_gravity_board[x+x_mov][y+y_mov].nil? == false
        if @rotated_gravity_board[x+x_mov][y+y_mov] == color && x+x_mov>=0 && y+y_mov>=0
          # p x+x_mov
          # p y+y_mov
          matching += 1
        end
      end
    end
    x += x_mov
    y += y_mov
  end
  set_result color, matching
  return if matching = @k - 1


end

1.upto(gets.to_i) do |case_number|

  @n, @k = gets.split.map(&:to_i)

  board = Array.new
  1.upto(@n) do
    board << gets.chomp.scan(/./)
  end
  rotated_board = Array.new(@n)
  rotated_board.map! { |x| x = Array.new}

  0.upto(@n-1) do |column|
    (@n-1).downto(0) do|row|
      rotated_board[column][@n-1-row] = board[row][column]
    end
  end

  @rotated_gravity_board = Marshal.load(Marshal.dump(rotated_board))

  # @rotated_gravity_board.each do |line|
  #   p line
  # end


  (@n-1).downto(0) do |row|
    0.upto(@n-1) do |column|
      if @rotated_gravity_board[row][column] =~ /[RB]/
        color = @rotated_gravity_board[row][column]
        (row+1).upto(@n-1) do |x|
          if @rotated_gravity_board[x][column] == '.'
            @rotated_gravity_board[x][column] = color
            @rotated_gravity_board[x-1][column] = '.'
          end
        end
        # @rotated_gravity_board.each do |line|
        #   p line
        # end

      end
    end
  end

  # @rotated_gravity_board.each do |line|
  #   p line
  # end




  @red = nil
  @blue = nil
  0.upto(@n-1) do |row|
    0.upto(@n-1) do |column|
      break if @blue == true && @red == true
      color_to_test = @rotated_gravity_board[row][column]
      if color_to_test != '.'
        test_position(row,column, 0, 1, color_to_test)
        test_position(row,column, 1, 0, color_to_test)
        test_position(row,column, 1, 1, color_to_test)
        test_position(row,column, 1, -1, color_to_test)
      end
    end
  end

  answer = 'Neither'
  if @red
    answer = 'Red'
  end
  if @blue
    answer = 'Blue'
  end
  if @red && @blue
    answer = 'Both'
  end

  puts "Case ##{case_number}: #{answer}"

end
