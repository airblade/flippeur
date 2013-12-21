require 'minitest/autorun'
require 'flippeur'
require 'flippeur/rails_helpers'


class Controller
  include Flippeur::ControllerHelpers
  def current_person
    Object.new
  end
end


class ControllerHelpersTest < MiniTest::Unit::TestCase

  def setup
    @controller = Controller.new
  end

  def test_unknown_feature_raises_exception
    Flippeur.setup { }
    assert_raises Flippeur::UnknownFeature do
      @controller.feature? :foo
    end
  end

  def test_available_feature_as_boolean
    Flippeur.setup do
      feature(:foo) { |actor| true }
    end
    assert @controller.feature?(:foo)
  end

  def test_available_feature_with_block
    Flippeur.setup do
      feature(:foo) { |actor| true }
    end
    block_called = false
    @controller.feature?(:foo) do
      block_called = true
    end
    assert block_called
  end

  def test_unavailable_feature_as_boolean
    Flippeur.setup do
      feature(:foo) { |actor| false }
    end
    refute @controller.feature?(:foo)
  end

  def test_unavailable_feature_with_block
    Flippeur.setup do
      feature(:foo) { |actor| false }
    end
    block_called = false
    @controller.feature?(:foo) do
      block_called = true
    end
    refute block_called
  end

end
