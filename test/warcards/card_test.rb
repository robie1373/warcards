require_relative '../test_helper'

module Cardgame
  class TestCard < MiniTest::Unit::TestCase
    def test_cards
      assert_instance_of Card, Card.new(:suit => :spades, :value => 10)
    end

    def test_card_has_suit
      assert_equal :hearts, Card.new(:suit => :hearts, :value => 10).suit
    end

    def test_card_has_value
      assert_equal 7, Card.new(:suit => :spades, :value => 7).value
    end

    def test_card_can_be_created_with_given_suit
      assert_equal :clubs, Card.new(:suit => :clubs).suit
    end

    def test_card_can_be_created_with_given_value
      assert_equal 3, Card.new(:value => 3).value
    end
  end
end