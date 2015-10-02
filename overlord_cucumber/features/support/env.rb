require "capybara/cucumber"
require "capybara/dsl"
require "capybara/rspec"
require "capybara/poltergeist"
require_relative "../../overlord"

Capybara.app = Overlord.new
Capybara.javascript_driver = :poltergeist
