require 'flippeur/rails_helpers'

module Flippeur
  class Railtie < Rails::Railtie
    initializer 'flippeur.rails_helpers' do
      ActionView::Base.send       :include, Flippeur::ViewHelpers
      ActionController::Base.send :include, Flippeur::ControllerHelpers
      ActiveRecord::Base.send     :include, Flippeur::ModelHelpers
    end
  end
end
