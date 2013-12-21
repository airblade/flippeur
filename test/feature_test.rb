require 'minitest/autorun'
require 'flippeur'

class FeatureTest < MiniTest::Unit::TestCase

  def test_unknown_features_raises_exception
    Flippeur.setup { }
    assert_raises Flippeur::UnknownFeature do
      Flippeur.find :foo
    end
  end

  def test_finds_known_feature
    Flippeur.setup do
      feature(:foo) { }
    end
    assert_instance_of Flippeur::Feature, Flippeur.find(:foo)
  end

  def test_available_feature
    Flippeur.setup do
      feature(:foo) { |actor| actor.id == 42 }
    end
    assert Flippeur.find(:foo).available?( OpenStruct.new(id: 42) )
  end

  def test_unavailable_feature
    Flippeur.setup do
      feature(:foo) { |actor| actor.id == 42 }
    end
    refute Flippeur.find(:foo).available?( OpenStruct.new(id: 153) )
  end

end
