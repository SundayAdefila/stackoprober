# module Push
#   class Stacko
#     require 'rubygems'
#     require 'mechanize'
#
#     def self.enter
#       me = Mechanize.new
#       me.get(ENV['BASE_URL']) do |page|
#         login_page = me.click(page.link_with(:text => /log in/))
#       end
#     end
#   end
#
#
#   ##################################################################
#   ##  THIS CLASS IS JUST A TEST TO UNDERSTAND HOW THIS WILL WORK  ##
#   ##  ON ANOTHER LOCAL PROJECT. MAIN METHOD IS THE ONE ABOVE. :)  ##
#   ##################################################################
#   class Cadw
#     require 'rubygems'
#     require 'mechanize'
#
#     def self.enter
#       me = Mechanize.new
#       me.get(ENV['TEST_BASE_URL']) do |page|
#         login_page = me.click(page.link_with(:text => /Sign in/))
#         login_form = login_page.form_with(:action => '/users/sign_in') do |f|
#           f.field_with(type: 'email').value = ENV['EMAIL_ADDRESS']
#           f.field_with(type: 'password').value = ENV['EMAIL_PASSWORD']
#         end.click_button
#       end
#     end
#   end
#
# end