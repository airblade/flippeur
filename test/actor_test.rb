require 'minitest/autorun'
require 'flippeur'
require 'flippeur/rails_helpers'

class ActorController
  include Flippeur::ControllerHelpers

  def current_person
    @method = :current_person
  end

  def current_account
    @method = :current_account
  end

  def method?
    @method
  end
end


class ActorView
  include Flippeur::ViewHelpers
  def initialize
    @controller = OpenStruct.new(current_account: Object.new)
  end
end


class ActorTest < MiniTest::Unit::TestCase

  def setup
    @controller = ActorController.new
    @view = ActorView.new
  end

  def test_default_actor_controller
    Flippeur.setup do
      feature(:foo) { |actor| true }
    end
    @controller.feature?(:foo)
    assert_equal :current_person, @controller.method?
  end

  def test_configured_actor_controller
    Flippeur.setup do
      actor :current_account
      feature(:foo) { |actor| true }
    end
    @controller.feature?(:foo)
    assert_equal :current_account, @controller.method?
  end

  def test_configured_actor_view
    Flippeur.setup do
      actor :current_account
      feature(:foo) { |actor| true }
    end
    assert @view.feature?(:foo)
  end

end
