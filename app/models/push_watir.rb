module PushWatir
  class Stacko
    def self.enter
      # browser = Watir::Browser.new # this uses firefox to see what is going on
      browser = Watir::Browser.new :phantomjs # this is an "headless" browser. no GUI
      browser.goto Rails.configuration.base_url
      #Log current url to console for debugging
      puts browser.url
      login_link_clicked(browser)
      Kernel.sleep 2
      puts browser.url.split('.')[0]

      #Log current url to console for debugging
      puts "url is: #{browser.url}. about to click google login"
      google_login_link_clicked(browser)
      Kernel.sleep 2
      puts browser.url.split('.')[0]
      #Log current url to console for debugging
      puts "About to fill in the Google mail address with: #{Rails.configuration.gmail_address}"

      # Fill in the email and click next
      browser.text_field(id: 'Email', name: 'Email').when_present.set Rails.configuration.gmail_address
      puts "Email entered"
      browser.input(id: 'next', value: 'Next').when_present.fire_event :click
      puts "Next button clicked"

      #Log current url to console for debugging
      puts "About to fill in the password with: #{Rails.configuration.gmail_password}"

      # Fill in the password and signin
      browser.text_field(id: 'Passwd', name: 'Passwd').when_present.set Rails.configuration.gmail_password
      puts "Password entered"
      browser.input(id: 'signIn', value: 'Sign in').when_present.fire_event :click
      puts "Google sign in button clicked"
      browser.div(id: 'header').div(id: 'hlogo').when_present

      Kernel.sleep 7
      puts browser.url.split('.')[0]
      text = get_page_text(browser)
      puts text

      #Log current url to console for debugging
      if text.include? 'Stack Overflow'
        puts "Successfully Logged in"
      else
        puts "Unable to Logged in"
      end

      #check my profile
      click_my_profile_link(browser)
      puts "profile clicked"
      play_around_small(browser)
      browser.close
      puts "All done"
      puts "*="*100

      # All done. Now send me a mail to inform me of your success
      # PushWatir::StackoMailer.success_mail.deliver_now!
    end

    def self.login_link_clicked(browser)
      browser.div(class: "topbar-links").when_present
          .div(class: 'links-container')
          .span(class: 'topbar-menu-links')
          .link(text: 'log in').click
      puts "login link clicked"
    end

    def self.google_login_link_clicked(browser)
      browser.div(id: 'openid-buttons').when_present
          .div(class: 'google-login')
          .fire_event :click
      puts 'google login link clicked'
    end

    def self.click_my_profile_link(browser)
      browser.div(class: "topbar-links").when_present
          .link(class: 'profile-me js-gps-track').click
    end

    def self.play_around_small(browser)
      links = ['Profile', 'Activity', 'Edit Profile & Settings']
      links.each do |link|
        browser.div(id: 'content').when_present
            .div(id: 'mainbar-full').when_present
            .div(class: 'subheader reloaded js-user-header').div(id: 'tabs').when_present
            .link(text: link).click
        puts "#{link} clicked"
        Kernel.sleep 2
      end
    end

    def self.get_page_text(browser)
      a = []
      b = browser.text.split(" ")
      0.upto 5 do |n|
        a << b[n]
      end
      a.join(" ")
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