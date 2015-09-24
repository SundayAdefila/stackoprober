module PushWatir
  class Cadw

    ##################################################################
    ##  THIS CLASS IS JUST A TEST TO UNDERSTAND HOW THIS WILL WORK  ##
    ##  ON ANOTHER LOCAL PROJECT. MAIN METHOD IS THE ONE BELOW. :)  ##
    ##################################################################

    def self.enter
      browser = Watir::Browser.new
      browser.goto ENV['TEST_BASE_URL']
      browser.a(:class, 'sign-in').click
      browser.text_field(:id => 'user_email').set ENV['TEST_EMAIL_ADDRESS']
      browser.text_field(:id => 'user_password').set ENV['TEST_EMAIL_PASSWORD']
      browser.button(:name => 'button', type: 'submit').click
    end
  end

  class Stacko
    def self.enter
      # browser = Watir::Browser.new # this uses firefox to see what is going on
      browser = Watir::Browser.new :phantomjs # this is an "headless" browser. no GUI
      browser.goto Rails.configuration.base_url
      #Log current url to console for debugging
      puts browser.url
      puts "log in link clicked" if login_link_clicked(browser)
      #Log current url to console for debugging
      puts "url is: #{browser.url}. about to click google login"
      puts "Google login link clicked" if google_login_link_clicked(browser)
      #Log current url to console for debugging
      puts "About to fill in the Google mail address"

      # Fill in the email and click next
      puts "Email entered" if browser.text_field(id: 'Email', name: 'Email').when_present.set Rails.configuration.gmail_address
      puts "Next button clicked" if browser.input(id: 'next', value: 'Next').fire_event :click

      #Log current url to console for debugging
      puts "About to fill in the password"

      # Fill in the password and signin
      puts "Password entered" if browser.text_field(id: 'Passwd', name: 'Passwd').when_present.set Rails.configuration.gmail_password
      puts "Google sign in button clicked" if browser.input(id: 'signIn', value: 'Sign in').fire_event :click

      sleep 10
      #Log current url to console for debugging
      puts "url: #{browser.url}  Logged in" if browser.text.include? 'Stack Overflow'
      browser.close
      puts "*="*100

      # All done. Now send me a mail to inform me of your success
      # PushWatir::StackoMailer.success_mail.deliver_now!
    end

    def self.login_link_clicked(browser)
      browser.div(class: "topbar-links").when_present
          .div(class: 'links-container')
          .span(class: 'topbar-menu-links')
          .link(text: 'log in').click
    end

    def self.google_login_link_clicked(browser)
      browser.div(id: 'openid-buttons').when_present
          .div(class: 'google-login')
          .fire_event :click
    end
  end


  class StackoMailer < ActionMailer::Base

    def success_mail
      @my_email = Rails.configuration.gmail_address
      mail(
        from: 'notifications@StackoProbe.com',
        to: @my_email,
        subject: 'Fuck Yeah! Visited successfully...'
      )
    end

    def failure_mail
      @my_email = Rails.configuration.gmail_address
      mail(
          from: 'notifications@StackoProbe.com',
          to: @my_email,
          subject: 'Uh...oh... Something seems to have gone wrong...'
      )
    end
  end
end