
def flow_down x, y
  x_flow, y_flow = 0, 0

  height = @map[x][y]
  if x > 0 && @map[x-1][y] < height #north
    height = @map[x-1][y]
    x_flow = -1
  end
  if y > 0 && @map[x][y-1] < height #west
    height = @map[x][y-1]
    x_flow = 0
    y_flow = -1
  end
  if y < @w - 1 && @map[x][y+1] < height #east
    height = @map[x][y+1]
    x_flow = 0
    y_flow = 1
  end
  if x < @h - 1 && @map[x+1][y] < height #south
    x_flow = 1
    y_flow = 0
  end

  if x_flow != 0 || y_flow != 0
    [x + x_flow, y + y_flow]
  else
    return nil
  end
end

1.upto(gets.to_i) do |case_number|

  @current_bassin = 'a'
  @h, @w = gets.split.map(&:to_i)
  @map = Array.new
  1.upto(@h) do
    @map << gets.chomp.split.map(&:to_i)
  end

  @answer = Marshal.load(Marshal.dump(@map))

  0.upto(@h-1).each do  |row|
    0.upto(@w-1).each do |column|

      if !@answer[row][column].is_a?(String)
        saved_cases = Array.new
        saved_cases << [row,column]
        letter_found = nil
        while true
          scase = saved_cases.last
          down = flow_down(scase[0], scase[1])
          if down
            if @answer[down[0]][down[1]].is_a?(String)
              letter_found = @answer[down[0]][down[1]]
              break
            else
              saved_cases << down
            end
          else
            break
          end
        end

        saved_cases.each do |element|
          if letter_found == nil
            if !(row == 0 && column == 0)
              @current_bassin = @current_bassin.next
            end
            letter_found = @current_bassin
          end
          @answer[element[0]][element[1]] = letter_found
        end

      end

      # @answer.each do |a|
      #   puts a.join(" ")
      # end
      # puts '-----------------------'

    end
  end



  puts "Case ##{case_number}:"
  @answer.each { |x| puts x.join(' ')}
end
