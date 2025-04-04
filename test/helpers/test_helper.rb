ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# Load Capybara for integration tests (optional, system tests handled separately)
require 'capybara/rails'
require 'capybara/minitest'

# Run tests in parallel (optional for performance)
class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  # Load all fixtures from test/fixtures/*.yml
  fixtures :all
end

# Allow Capybara matchers in integration tests (optional)
class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  teardown do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
