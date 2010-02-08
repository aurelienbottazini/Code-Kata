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

#TODO check when no distribution present or all 0
class FairDistribution

  def initialize jobs, number_of_presses

    @distributions = Array.new

    @number_of_presses = number_of_presses

    distrib = Array.new
    distrib << Array.new
    job_index = 0
    max = 0
    jobs.each_with_index do |job, index|
      if job > max
        max = job
        job_index = index
      end
    end

    distrib[0] << max
    jobs.slice!(job_index)
    distribute_jobs distrib, jobs

    p @distributions
  end


  def time_required

    time_required = 0.0

    @distributions.each do |dist|
      distribution_max = 0
      dist.each do |press|
        if press.reduce(0.0, :+) > distribution_max
          distribution_max =  press.reduce(0.0, :+)
        end
      end

      if time_required = 0 || time_required > distribution_max
        time_required = distribution_max
      end

    end

    return time_required
  end

  def distribution
    distrib = nil

    time_required = 0.0
    
     @distributions.each do |dist|
      distribution_max = 0
      dist.each do |press|
        if press.reduce(0.0, :+) > distribution_max
          distribution_max =  press.reduce(0.0, :+)
        end
      end

      if time_required = 0 || time_required > distribution_max
        time_required = distribution_max
        distrib = dist
      end

    end
    
    return distrib
  end

  private

  def distribute_jobs distrib, jobs

    if distrib.size == @number_of_presses
      # we are done, add remaining job in new press and add / return
      # solution
      distrib.pop
      distrib << jobs

      distribution_max = 0
      distrib.each do |press|
        if press.reduce(0.0, :+) > distribution_max
          distribution_max =  press.reduce(0.0, :+)
        end
      end

      if distribution_max < time_required || time_required == 0 
              @distributions << distrib
      end
      return
    end

    
    jobs.each_with_index do |job, index|
      new_distribution = Array.new
      distrib.each { |e| new_distribution << e.dup }

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
jobs              = [1.0, 4.75, 2.83, 1.1, 5.8, 3.5, 4.4]
number_of_presses = 4

fd = FairDistribution.new(jobs, number_of_presses)
p fd.time_required
p fd.distribution
