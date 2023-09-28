require "rufus-scheduler"

class CronScheduler
  def initialize
    @scheduler = Rufus::Scheduler.new
    @jobs = {} 
  end

  def start
    @scheduler_thread = Thread.new { @scheduler.join }
  end

  def get_jobs
    @jobs
  end

  def get_scheduler
    @scheduler
  end

  def schedule_job(identifier, frequency, expected, job)
    @jobs[identifier] = [{ job_id: identifier, expected: expected, frequency: frequency, job: job }]
    schedule_job_with_rufus(identifier, frequency)
  end

  def schedule_job_with_rufus(identifier, frequency)
    @scheduler.every(frequency) do
      execution_start_time = Time.now
      eval(@jobs[identifier][0][:job])
      execution_end_time = Time.now
      execution_time = execution_end_time - execution_start_time
      @jobs[identifier] << { execution_time: execution_time, execution_start_time: execution_start_time, execution_end_time: execution_end_time }
		end
    start
  end

  def log_job_execution
    @jobs.each do |key, value|
      puts "Job '#{key}' execution start time: #{value[value.size-1][:execution_start_time]}\n"
      puts "Job '#{key}' execution end time: #{value[value.size-1][:execution_end_time]}\n"
      puts "Job '#{key}' expected execution time: #{value[0][:expected]}\n"
      puts "Job '#{key}' execution time: #{value[value.size-1][:execution_time]}\n"
			puts
    end
  end
end
