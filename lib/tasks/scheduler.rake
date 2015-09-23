desc "This task is called by the Heroku scheduler add-on"

task :probe_stacko => :environment do
  puts "Racking up prescence on Stacko"
  PushWatir::Stacko.enter
end