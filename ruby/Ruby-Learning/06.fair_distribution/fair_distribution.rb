require 'rubygems'
require 'ruby-debug'

class FairDistribution

  attr_accessor :distribution

  def initialize jobs, number_of_presses

    @distribution = nil

    @number_of_presses = number_of_presses

    distrib = Array.new
    distrib << Array.new
    distribute_jobs distrib, jobs.dup
  end

  def time_required distrib=@distribution

    if distrib == nil
      return 0
    end

    time_required = 0.0

    distrib[0..distrib.size].each do |d|
      if d.reduce(0.0, :+) > time_required || time_required == 0.0
        time_required = d.reduce(0.0, :+)
      end
    end

    return time_required
  end

  private

  def distribute_jobs distrib, jobs

    # si on est au nombre max de distrib, on arrete
    if distrib.size == @number_of_presses
      jobs.each do |job|
        distrib.last << job
      end

      if  time_required(distrib) < time_required(@distribution) || @distribution == nil
        @distribution = distrib
      end
    end

    if time_required(distrib) <= time_required || time_required == 0
      jobs.each_with_index do |job, index|
        distrib_copy =  dup_distrib(distrib)

        distrib_copy.last << job
        jobs_copy = jobs.dup
        jobs_copy.slice!(index)

        distribute_jobs distrib_copy, jobs_copy

        distrib_copy2 = dup_distrib(distrib_copy)
        distrib_copy2 << Array.new
        distribute_jobs distrib_copy2, jobs_copy.dup
      end
    end
  end

  def dup_distrib distrib
    new_distrib = Array.new

    distrib.each do |d|
      new_distrib << d.dup
    end

    return new_distrib
  end

  def standard_deviation distrib
    mean = 0.0
    sum = 0.0
    distrib.each do |d|
      sum =+ d.reduce(0.0, :+)
    end

    mean = sum / distrib.size

  end

end


# fd = FairDistribution.new([0.23, 0.47, 0.73, 1.5, 3.0, 3.2], 4)
# fd.time_required
# p fd.distribution

def standard_deviation distrib

  sums = Array.new
  distrib.each do |d|
    sums << d.reduce(0.0, :+)
  end

  mean = sums.reduce(0.0, :+) / distrib.size
  variance = sums.inject(0.0) {|sum, n| sum + (n - mean) * (n - mean) } / distrib.size

  return Math.sqrt(variance)
end

p standard_deviation  [
                       [2],
                       [4],
                       [4],
                       [4],
                       [5],
                       [5],
                       [7],
                       [9]
                      ]
