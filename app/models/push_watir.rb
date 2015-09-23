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
      browser = Watir::Browser.new
      browser.goto Rails.configuration.base_url
      browser.div(class: "topbar-links")
          .div(class: 'links-container')
          .span(class: 'topbar-menu-links')
          .link(text: 'log in').click
      browser.div(id: 'openid-buttons')
          .div(class: 'google-login')
          .fire_event :click

      # Fill in the email and click next
      browser.text_field(id: 'Email', name: 'Email').set Rails.configuration.gmail_address
      browser.input(id: 'next', value: 'Next').fire_event :click

      # Fill in the password and signin
      browser.text_field(id: 'Passwd', name: 'Passwd').when_present.set Rails.configuration.gmail_password
      browser.input(id: 'signIn', value: 'Sign in').fire_event :click

      # All done. Now send me a mail to inform me of your success
      PushWatir::StackoMailer.success_mail.deliver_now!
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
  end
end