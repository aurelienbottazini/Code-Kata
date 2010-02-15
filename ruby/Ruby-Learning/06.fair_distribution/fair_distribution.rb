require 'rubygems'
require 'ruby-debug'

class FairDistribution

  attr_accessor :distribution, :time_required

  def initialize jobs, number_of_presses

    @distribution      = nil
    @number_of_presses = number_of_presses
    @time_required = jobs.reduce(0.0, :+)
    distrib = [[]]
    distribute_jobs distrib, jobs.dup
  end


  private

  def distribute_jobs distrib, jobs

    # si on est au nombre max de distrib, on arrete
    if distrib.size == @number_of_presses
      while !jobs.empty?
        distrib.last << jobs.pop
      end

      if @distribution == nil
        @distribution = distrib
      elsif FairDistribution.time_required(distrib) <= @time_required
        if FairDistribution.standard_deviation(distrib) < FairDistribution.standard_deviation(@distribution)
          @distribution = distrib
          @time_required = FairDistribution.time_required(@distribution)
        end
      end
    end

    if FairDistribution.time_required(distrib) <= @time_required
      jobs.each_with_index do |job, index|

        # distrib_copy =  dup_distrib(distrib)
        # jobs_copy = jobs.dup

        # current_press_time = distrib_copy.last.reduce(0.0, :+)

        # if current_press_time < jobs_copy.reduce(0.0, :+)
        #   distrib_copy.last << job
        #   jobs_copy.slice!(index)
        # else
        #   distrib_copy << Array.new
        # end

        # distribute_jobs distrib_copy, jobs_copy

        distrib_copy =  FairDistribution.dup_distrib(distrib)
        distrib_copy.last << job
        jobs_copy = jobs.dup
        jobs_copy.slice!(index)

        distrib_copy2 = FairDistribution.dup_distrib(distrib_copy)
        distrib_copy2 << Array.new
        jobs_copy2 = jobs_copy.dup


        distribute_jobs distrib_copy, jobs_copy
        distribute_jobs distrib_copy2, jobs_copy2
      end
    end
  end

  def self.dup_distrib distrib

    new_distrib = Array.new
    distrib.each do |d|
      new_distrib << d.dup
    end

    return new_distrib
  end

  def self.standard_deviation distrib

    sums = Array.new
    distrib.each do |d|
      sums << d.reduce(0.0, :+)
    end

    mean = sums.reduce(0.0, :+) / distrib.size
    variance = sums.inject(0.0) {|sum, n| sum + (n - mean) * (n - mean) } / distrib.size
    return Math.sqrt(variance)
  end

  def self.time_required distrib

    time_required = 0.0
    if distrib != nil
      distrib.each do |d|
        d_time_required = d.reduce(0.0, :+)
        if  d_time_required > time_required
          time_required = d_time_required
        end
      end
    end

    return time_required
  end

end

jobs              = [1.0, 4.75, 2.83, 1.1, 5.8, 3.5, 4.4]
number_of_presses = 4

fd = FairDistribution.new(jobs, number_of_presses)
p fd.time_required
p fd.distribution
