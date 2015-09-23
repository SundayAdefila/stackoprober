module PushWatir
  class Cadw
    def self.enter
      browser = Watir::Browser.new
      browser.goto ENV['TEST_BASE_URL']
      browser.a(:class, 'sign-in').click
      browser.text_field(:id => 'user_email').set ENV['EMAIL_ADDRESS']
      browser.text_field(:id => 'user_password').set ENV['EMAIL_PASSWORD']
      browser.button(:name => 'button', type: 'submit').click
    end

  end
end