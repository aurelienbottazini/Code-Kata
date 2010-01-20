class Maze

  ENTRANCE = 'A'
  EXIT = 'B'
  MARK = 'T'
  WALL = '#'

  Position = Struct.new(:row, :column)

  def initialize maze
    # converting maze string to a two dimensional array for easier navigation
    @maze = maze.split(/\n/).map!{|line| line.chars.to_a }
  end

  def solvable?
    return find_exit(find_entrance, 0)
  end

  def steps
    
    @steps = 0
    solvable?

    return @steps
  end

  private

  def find_entrance

    @maze.each_with_index do |row, row_index|
      column_index = row.index(ENTRANCE)
      if column_index
        return Position.new(row_index, column_index)
      end
    end

    return raise "Error: Maze has no entrance"
  end

  def is_exit?(position)
    get_char(position) == EXIT ? true : false
  end

  def already_tried?(position)
    get_char(position) == MARK ? true : false
  end

  def mark_as_tried(position)
    set_char(position, MARK)
  end

  # Recursively tries to find an exit and also sets the number of
  # steps upon success in @steps
  def find_exit(position, steps)

    if already_tried?(position)
      return false
    end

    if is_exit?(position)
      @steps = steps
      return true
    end

    mark_as_tried(position)

    left = Position.new(position.row, position.column - 1)
    if movable?(left)
      if find_exit(left, steps + 1)
        return true
      end
    end

     right = Position.new(position.row, position.column + 1)
    if movable?(right)
      if find_exit(right, steps + 1)
        return true
      end
    end

    up = Position.new(position.row - 1, position.column)
    if movable?(up)
      if find_exit(up, steps + 1)
        return true
      end
    end

    down = Position.new(position.row + 1, position.column)
    if movable?(down)
      if find_exit(down, steps + 1)
        return true
      end
    end

    return false
  end

   def movable?(position)
    if get_char(position) != WALL &&
        get_char(position) != MARK
      return true
    end

    return false
  end

   def get_char position
    @maze[position.row][position.column]
  end

  def set_char position, char
    @maze[position.row][position.column] = char
  end
end
