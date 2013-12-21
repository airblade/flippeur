module Flippeur
  class Feature
    attr_reader :name, :block

    def initialize(name, &block)
      @name = name
      @block = block
    end

    def available?(actor)
      block.call actor
    end
  end
end
