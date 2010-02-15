=begin
Original problem  url: http://rubylearning.com/blog/2010/01/26/rpcfn-fair-distribution-6/

The goal of this class is to schedule printing jobs between printing machines (presses)

  Jobs should be distributed "in such a manner that (a) all t-shirts are printed in the least amount of time,
 and (b) the distribution of work across machines is as fair as possible (i.e. the standard deviation
 of the time each machine spends working is minimized)."


Class ensure that number_of_presses is valid (positive and an integer)
Class ensure that jobs is an array containing only positive numeric
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
    @time_required     = jobs.reduce(0.0, :+)
    @signatures        = Hash.new
    @distribution      = []
    number_of_presses.times { @distribution << Array.new }
    
    distrib = [[]]
    distribute_jobs distrib, jobs.dup
  end


  private

  def distribute_jobs distrib, jobs

    if distrib.size == @number_of_presses
      while !jobs.empty?
        distrib.last << jobs.pop
      end

      if FairDistribution.is_distribution_empty?(@distribution)
        @distribution = distrib
      elsif FairDistribution.time_required(distrib) <= @time_required
        if FairDistribution.standard_deviation(distrib) < FairDistribution.standard_deviation(@distribution)
          @distribution = distrib
          @time_required = FairDistribution.time_required(@distribution)
        end
      end
    end

    signature = String.new
    distrib.each_with_index {|e, index| distrib[index] = e.sort }
    distrib.sort {|a,b| a.reduce(0.0, :+) <=> b.reduce(0.0, :+)}.each { |e| signature << "#{e};"}
    signature << "||"
    jobs.each { |j| signature << "#{j};"}
    
    if !@signatures.key?(signature) && FairDistribution.time_required(distrib) <= @time_required
      @signatures[signature] = 1
      jobs.each_with_index do |job, index|

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
