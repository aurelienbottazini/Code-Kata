=begin
Original url: http://rubylearning.com/blog/2009/12/27/rpcfn-mazes-5/

"In this Ruby challenge, you will need to develop a class that can be used
 to solve mazes. Mazes will be provided as a string showing a graphical representation
of the maze's layout. Spaces are navigable, while # (pound) symbols #
 are used to denote walls. In this challenge the letter A is used to mark the start
 point, and B the end point."
=end
class Maze

  ENTRANCE = 'A'
  EXIT = 'B'
  MARK = 'T'
  WALL = '#'

  Position = Struct.new(:row, :column)

  def initialize maze
    # converting maze string to a two dimensional array for easier navigation
    @maze = maze.split(/\n/).map!{|line| line.chars.to_a }
    @steps = Array.new
  end

  def solvable?
    return find_exit(find_entrance, 0, dup_maze(@maze))
  end

  def steps

    solvable?
    return (@steps.size > 0 ) ? @steps.min : 0
  end

  private

  def dup_maze maze
    new_maze = Array.new
    maze.each { |maze_element| new_maze << maze_element.dup }
    return new_maze
  end

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
    get_char(position, @maze) == EXIT ? true : false
  end

  def already_tried?(position, maze)
    get_char(position, maze) == MARK ? true : false
  end

  def mark_as_tried(position, maze)
    set_char(position, MARK, maze)
  end

  # Recursively tries to find exits and also register the number of
  # steps when an way to exit the maze is found in @steps
  # This algorithm will try find all possible paths
  def find_exit(position, steps, maze)

    if is_exit?(position)
      @steps << steps
    end

    mark_as_tried(position, maze)

    left = Position.new(position.row, position.column - 1)
    if movable?(left, maze)
      find_exit(left, steps + 1, dup_maze(maze))
    end

    right = Position.new(position.row, position.column + 1)
    if movable?(right, maze)
      find_exit(right, steps + 1, dup_maze(maze))
    end

    up = Position.new(position.row - 1, position.column)
    if movable?(up, maze)
      find_exit(up, steps + 1, dup_maze(maze))
    end

    down = Position.new(position.row + 1, position.column)
    if movable?(down, maze)
      find_exit(down, steps + 1, dup_maze(maze))
    end

    return (@steps.size > 0) ? true : false
  end

  def movable?(position, maze)
    if get_char(position, maze) != WALL &&
        get_char(position, maze) != MARK
      return true
    end

    return false
  end

  def get_char position, maze
    maze[position.row][position.column]
  end

  def set_char position, char, maze
    maze[position.row][position.column] = char
  end
end

MAZE7 = %{##############
#A           #
######## ## ##
#B           #
##############}

Maze.new(MAZE7).steps
