=begin
Original problem  url: http://rubylearning.com/blog/2010/01/26/rpcfn-fair-distribution-6/

The goal of this class is to schedule printing jobs between printing machines (presses)

  Jobs should be distributed "in such a manner that (a) all t-shirts are printed in the least amount of time,
 and (b) the distribution of work across machines is as fair as possible (i.e. the standard deviation
 of the time each machine spends working is minimized)."


Class ensure that number_of_presses is valid (positive and an integer)
Class ensure that jobs is an array containing only positive numeric

Usage:
 jobs = [5,5,4,4,3,3,3]
 number_of_presses = 3

 fd = FairDistribution.new(jobs, number_of_presses)
 fd.time_required
 fd.distribution
=end
class FairDistribution

  attr_accessor :distribution, :time_required

  def initialize jobs, number_of_presses

    if number_of_presses.integer? == false || number_of_presses < 1
      raise ArgumentError, "The number of presses needs to be an integer greater or equal to 1"
    end

    if jobs.is_a?(Array) == false
      raise ArgumentError, "jobs should be an array containing positive numeric"
    end

    jobs.each do |job|
      if job.is_a?(Numeric) == false || job < 0
        raise ArgumentError, "All Jobs should be positive numeric"
      end
    end

    @number_of_presses = number_of_presses

    # starting with the highest time possible (sum of all jobs)
    @time_required     = jobs.reduce(0.0, :+)

    # will hold signatures of tested distributions (so that we don't
    # try to compute the same distribution twice)
    @signatures        = Hash.new

    #initializing an empty distribution with the correct number of presses
    @distribution      = []
    number_of_presses.times { @distribution << Array.new }

    # sets @time_required and @distribution
    distribute_jobs [[]], jobs.dup
  end


  private

  # Recusive procedure
  # It should be called initially with a list of jobs and an empty
  # distribution containing one empty press ( = [[]]).
  # It will try to find the optimal distribution and store it in
  # @distribution. It will also store the time required by this
  # optimal distribution in @time_required.
  def distribute_jobs distrib, jobs

    # we can stop, we have reached the maximum number of press
    if distrib.size == @number_of_presses

      # copy the remaining jobs in last press and empty jobs array
      while !jobs.empty?
        distrib.last << jobs.pop
      end

      # we don't have any solution yet, copy this one
      if FairDistribution.is_distribution_empty?(@distribution)
        @distribution = distrib
      # let's check if this distribution is better than our previous
      # best and make it the new solution if it is
      elsif FairDistribution.time_required(distrib) <= @time_required &&
          FairDistribution.standard_deviation(distrib) < FairDistribution.standard_deviation(@distribution)
        @distribution = distrib
        @time_required = FairDistribution.time_required(@distribution)
      end

      return
    end

    # create a signature for this distribution so that we don't test twice
    # identical distributions
    signature = String.new
    distrib.each_with_index {|e, index| distrib[index] = e.sort }
    distrib.sort {|a,b| a.reduce(0.0, :+) <=> b.reduce(0.0, :+)}.each do |press|
      press.each { |job| signature << "#{job};" }
      signature << "|"
    end

    # have we tried yet this distribution?
    if @signatures.key?(signature) == false
      # we should stop testing this distribution as possible answer if
      # we have exceeded the @time_required of our current best distribution
      if FairDistribution.time_required(distrib) <= @time_required

        # mark this distribution has tried
        @signatures[signature] = 1

        jobs.each_with_index do |job, index|

          # we create a new distribution, adding one job in last press
          distrib_copy =  FairDistribution.dup_distrib(distrib)
          distrib_copy.last << job

          # we create a new distribution, adding one job in last press
          # and adding a new press
          distrib_copy2 = FairDistribution.dup_distrib(distrib_copy)
          distrib_copy2 << Array.new

          jobs_copy = jobs.dup
          jobs_copy.slice!(index)
          jobs_copy2 = jobs_copy.dup

          distribute_jobs distrib_copy, jobs_copy
          distribute_jobs distrib_copy2, jobs_copy2
        end
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

  # empty meaning distribution containing no press or presses
  # but without any jobs
  def self.is_distribution_empty? distrib
    is_empty = true

    distrib.each do |d|
      if d.size > 0
        is_empty = false
        break
      end
    end

    return is_empty
  end

end
