desc "This task is called by the Heroku scheduler add-on"

task :probe_stacko => :environment do
  puts "Racking up prescence on Stacko. Time: => #{Time.now.strftime("%H:%M - %A %d %b %Y")}"
  PushWatir::Stacko.enter
end