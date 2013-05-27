require 'flippeur/railtie' if defined?(Rails)
require 'flippeur/feature'
require "flippeur/version"

module Flippeur

  UnknownFeature = Class.new RuntimeError

  def self.setup(&block)
    reset
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
    @features ||= Hash.new { |_,k| raise UnknownFeature, "Unknown feature: #{k}" }
  end

  def self.reset
    @features = nil
  end
  
end
