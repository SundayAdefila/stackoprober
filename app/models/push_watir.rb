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
      browser.goto ENV['BASE_URL']
      browser.div(class: "topbar-links")
          .div(class: 'links-container')
          .span(class: 'topbar-menu-links')
          .link(text: 'log in').click
      browser.div(id: 'openid-buttons')
          .div(class: 'google-login')
          .fire_event :click

      # Fill in the email and click next
      browser.text_field(id: 'Email', name: 'Email').set ENV['GMAIL_ADDRESS']
      browser.input(id: 'next', value: 'Next').fire_event :click

      # Fill in the password and signin
      browser.text_field(id: 'Passwd', name: 'Passwd').when_present.set ENV['GMAIL_PASSWORD']
      browser.input(id: 'signIn', value: 'Sign in').fire_event :click
    end
  end
end