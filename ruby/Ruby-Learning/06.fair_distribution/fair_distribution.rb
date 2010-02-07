=begin rdoc
I start with a number of press and numbers.
I create all possible list of distribution containing the largest number + *1,(associated remaining numbers). I compute the following average: remaining numbers sum/number of remaining presses
  if average < current_distrib_sum-> mark as possible
if everything is impossible we recreate all the tuples but this time with one more number and redo the average computation
else we have possibles solutions
  if press = 1
    we put all remaning numbers in the last press and we have a solution I save it
  else
    I follow the same logic with the remaining numbers, creating tuples computing average etc...

at the end I take the minimal solution in my list

=end
class FairDistribution

  def initialize jobs, number_of_presses

    @press_array = Array.new
    1.upto(number_of_presses) { @press_array << Press.new }
 
    @jobs = jobs.sort {|x,y| y <=> x }
    @jobs.each do |job|
      press = get_lazy_press
      press.add_job(job)
    end

    p distribution
  end

  def time_required
    return get_hard_worker_press.work
  end

  def distribution
    @press_array.map { |press| press.job_list}
  end

  private

  Press = Class.new do
    attr_reader :job_list

    def initialize
      @job_list = Array.new
    end

    def add_job job
      @job_list << job
    end

    def work
      sum = 0
      @job_list.each do |job|
        sum = sum + job
      end
      sum
    end
  end

  def get_lazy_press
    @press_array.min { |a,b| a.work <=> b.work }
  end

  def get_hard_worker_press
    @press_array.max { |a,b| a.work <=> b.work }
  end

end
