# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron


# Seems this will not work on heroku.
# Check lib/tasks/scheduler.rake for the one to be run on heroku

every 6.hours do

  runner "PushWatir::Stacko.enter"
  # command "/usr/bin/some_great_command"
  # rake "some:great:rake:task"
end

