require 'httparty'

require 'ruby-updater/version'

require 'ruby-updater/bundler_service'
require 'ruby-updater/git_service'
require 'ruby-updater/rubygems_service'
require 'ruby-updater/cli'

module RubyUpdater
  class Error < StandardError; end
end
