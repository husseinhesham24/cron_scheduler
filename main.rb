require "./validate.rb"
require "./scheduler.rb"
require "./job.rb"
require "rufus-scheduler"

def add_job(job_list)
  scheduler = CronScheduler.new
  begin
    puts "please enter expected interval, Valid formats: 10s, 30m, 1h, 2d"
    expected_interval = gets.chomp
  end while !validate_interval(expected_interval)

  #puts "expected_interval: #{expected_interval}"

  begin
    puts "please enter schedule frequency, Valid formats: 10s, 30m, 1h, 2d"
    frequency = gets.chomp
  end while !validate_frequency(frequency)

  begin
    puts "please enter job identifier"
    job_identifier = gets.chomp
  end while !validate_uniqueness(job_list, job_identifier)

  job_list << scheduler

  scheduler.schedule_job(job_identifier, frequency, expected_interval, method(:job))
end

puts "welcome to Telda cron scheduler"
2.times do
  puts
end

flag = true

job_list = []

while true
  if flag
    puts "you have 3 options in our application please choose one of the following: "
  else
    puts "Do you want anything else ^-^? "
  end

  puts "press(1): Adding a job "
  puts "press(2): listing jobs "
  puts "press(anykey): close application"

  option = gets.chomp

  if option == "1"
    add_job(job_list)
    2.times do
      puts
    end
  elsif option == "2"
    if job_list.size > 0
      job_list.each do |obj|
        obj.log_job_execution
      end
    else
      puts "There is no jobs right now ^-^"
    end

    puts
  else
    break
  end

  flag = false
end

2.times do
  puts
end
puts "Thank you for using our application ^-^"
