require 'webserver_log_parser'
require_relative './support/matchers'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
  end
  SimpleCov.minimum_coverage 100
  SimpleCov.refuse_coverage_drop
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
