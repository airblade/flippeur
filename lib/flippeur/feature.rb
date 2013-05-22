module Flippeur
  class Feature
    attr_reader :name, :block

    def initialize(name, &block)
      @name = name
      @block = block
    end

    def available?(user)
      block.call user
    end
  end
end
