require 'flippeur/railtie' if defined?(Rails)
require 'flippeur/feature'
require "flippeur/version"

module Flippeur

  def self.setup(&block)
    module_eval &block
  end

  def self.feature(name, &block)
    features[name] = Feature.new(name, &block)
  end

  def self.find(name)
    features[name]
  end

  private

  def self.features
    @features ||= Hash.new { |_,k| raise "Unknown feature: #{k}" }
  end
  
end
