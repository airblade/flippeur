module Flippeur

  module ViewHelpers
    def feature?(name)
      available = Flippeur.find(name).available? @controller.current_person
      block_given? ? (yield if available) : available
    end
  end

  module ControllerHelpers
    def feature?(name)
      available = Flippeur.find(name).available? current_person
      block_given? ? (yield if available) : available
    end
  end

  module ModelHelpers
    def feature?(name, person)
      available = Flippeur.find(name).available? person
      block_given? ? (yield if available) : available
    end
  end

end
