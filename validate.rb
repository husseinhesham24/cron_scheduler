require "parser/current"

def validate_interval(interval)
  valid_intervals = ["s", "m", "h", "d"]  # Valid interval units: minutes, hours, days

  if interval =~ /^(\d+)([#{valid_intervals.join}])$/
    # puts "Interval are valid."
    return true
  else
    puts "Invalid interval format. Valid formats: 10s, 30m, 1h, 2d"
    return false
  end
end

def validate_frequency(frequency)
  valid_frequencies = ["s", "m", "h", "d"]  # Valid frequency units: minutes, hours, days

  if frequency =~ /^(\d+)([#{valid_frequencies.join}])$/
    # puts "Interval are valid."
    return true
  else
    puts "Invalid frequency format. Valid formats: 10s, 30m, 1h, 2d"
    return false
  end
end

def validate_uniqueness(job_id_list, job_identifier)
  if job_id_list.any? { |map| map.get_jobs.key?(job_identifier) }
    puts "This job identifier already exist!"
    return false
  else
    return true
  end
end
