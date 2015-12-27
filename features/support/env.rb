ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'lib/dashboard.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'cucumber/api_steps'

Capybara.app = Dashboard

class DashboardWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers

  def app
    Dashboard
  end
end

World do
  DashboardWorld.new
end
