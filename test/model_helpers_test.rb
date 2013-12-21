require 'minitest/autorun'
require 'flippeur'
require 'flippeur/rails_helpers'


class Model
  include Flippeur::ModelHelpers
end


class ModelHelpersTest < MiniTest::Unit::TestCase

  def setup
    @model = Model.new
  end

  def test_unknown_feature_raises_exception
    Flippeur.setup { }
    assert_raises Flippeur::UnknownFeature do
      @model.feature? :foo, Object.new
    end
  end

  def test_available_feature_as_boolean
    Flippeur.setup do
      feature(:foo) { |actor| true }
    end
    assert @model.feature?(:foo, Object.new)
  end

  def test_available_feature_with_block
    Flippeur.setup do
      feature(:foo) { |actor| true }
    end
    block_called = false
    @model.feature?(:foo, Object.new) do
      block_called = true
    end
    assert block_called
  end

  def test_unavailable_feature_as_boolean
    Flippeur.setup do
      feature(:foo) { |actor| false }
    end
    refute @model.feature?(:foo, Object.new)
  end

  def test_unavailable_feature_with_block
    Flippeur.setup do
      feature(:foo) { |actor| false }
    end
    block_called = false
    @model.feature?(:foo, Object.new) do
      block_called = true
    end
    refute block_called
  end

end
