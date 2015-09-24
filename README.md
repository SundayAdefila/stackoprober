## README

This project is an attempt at getting a script that could be visiting a site on my behalf at a specific time each day.

###### Ruby version
Ruby 2.2.1
###### System dependencies
 * Nokogiri
 * phantomJs `brew install phantomjs` on macOS

###### Configuration
clone project, run bundle install, (dont forget to install figaro after this: `bundle exec figaro install` and populate application.yml with environmental data) no need to run any migrations as there is no database...

###### How to run the test suite
As at now, there is no test yet #shy_to_admit

###### Services (job queues, cache servers, search engines, etc.)
Using Whenever to run schedueled jobs

Also Using Mailers for sending success emails.

###### Deployment instructions
you can always create a new branch to make additions/subtractions/modifications and then send out a pull request. It will be attended to. :)


Thanks for reading.
