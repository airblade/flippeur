require 'minitest/autorun'
require 'flippeur'
require 'flippeur/rails_helpers'


class View
  include Flippeur::ViewHelpers
  def initialize
    @controller = OpenStruct.new(current_person: Object.new)
  end
end


class ViewHelpersTest < MiniTest::Unit::TestCase

  def setup
    @view = View.new
  end

  def test_unknown_feature_raises_exception
    Flippeur.setup { }
    assert_raises Flippeur::UnknownFeature do
      @view.feature? :foo
    end
  end

  def test_available_feature_as_boolean
    Flippeur.setup do
      feature(:foo) { |actor| true }
    end
    assert @view.feature?(:foo)
  end

  def test_available_feature_with_block
    Flippeur.setup do
      feature(:foo) { |actor| true }
    end
    block_called = false
    @view.feature?(:foo) do
      block_called = true
    end
    assert block_called
  end

  def test_unavailable_feature_as_boolean
    Flippeur.setup do
      feature(:foo) { |actor| false }
    end
    refute @view.feature?(:foo)
  end

  def test_unavailable_feature_with_block
    Flippeur.setup do
      feature(:foo) { |actor| false }
    end
    block_called = false
    @view.feature?(:foo) do
      block_called = true
    end
    refute block_called
  end

end
