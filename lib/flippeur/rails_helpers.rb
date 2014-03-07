module Flippeur

  module ViewHelpers
    def feature?(name)
      available = Flippeur.find(name).available? controller.send(Flippeur.actor)
      block_given? ? (yield if available) : available
    end
  end

  module ControllerHelpers
    def feature?(name)
      available = Flippeur.find(name).available? send(Flippeur.actor)
      block_given? ? (yield if available) : available
    end
  end

  module ModelHelpers
    def feature?(name, actor)
      available = Flippeur.find(name).available? actor
      block_given? ? (yield if available) : available
    end
  end

end
