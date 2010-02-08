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

    @number_of_presses = number_of_presses

    distribution = Array.new
    distribution << Array.new
    distribution[0] << jobs.max
    distribute_jobs distribution, jobs

    p @press_array
  end


  def time_required
    return get_hard_worker_press.work
  end

  def distribution
    @press_array.map { |press| press.job_list}
  end

  private

  def distribute_jobs distribution, jobs

    if distribution.size == @number_of_presses
      # we are done, add remaining job in new press and add / return
      # solution
      distribution.pop
      distribution << jobs
      @press_array << distribution
      return
    end

    jobs.each_with_index do |job, index|
      new_distribution = Array.new
      distribution.each { |e| new_distribution << e.dup }

      new_distribution.last << job

      jobs_copy = jobs.dup
      jobs_copy.slice!(index)
      
      average = jobs_copy.reduce(0.0, :+) / (@number_of_presses - new_distribution.size)
      if average <= new_distribution.last.reduce(0.0, :+)
        new_distribution << Array.new
      end

      distribute_jobs new_distribution, jobs_copy
    end

  end

end


jobs              = [10, 15, 20, 24, 30, 45, 75]
number_of_presses = 2

exp_max           = 110

fd = FairDistribution.new(jobs, number_of_presses)
