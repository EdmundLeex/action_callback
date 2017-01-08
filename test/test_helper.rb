$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'minitest/reporters'
# require 'minitest/debugger'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

require 'action_callback'