require 'httmultiparty'

require 'floud_api/configuration'
require 'floud_api/client'
require 'floud_api/client/event'
require 'floud_api/client/organization'
require 'floud_api/client/account'

require 'floud_api/version'
# require_relative 'floud_api/organization'

# Floud API main module
module FloudApi
  attr_accessor :configuration

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
