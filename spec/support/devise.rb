require 'devise'
require_relative './devise/controller_macros'

RSpec.configure do |config|
  config.include Devise::TestHelpers,      type: :controller
  config.include Devise::ControllerMacros, type: :controller
end
