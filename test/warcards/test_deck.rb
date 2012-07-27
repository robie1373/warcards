require_relative '../test_helper'
module Cardgame
  class TestDeck < MiniTest::Unit::TestCase
    def setup
      @deck    = Deck.new
    end

    def test_deck
      assert_instance_of Deck, @deck
    end

    def test_deck_has_52_cards
      assert_equal 52, @deck.length
    end

    def test_deck_has_13_of_each_suit
      h = Hash.new(0)
      @deck.each { |card| h[card.suit] += 1 }
      h.each_key do |suit|
        assert_equal 13, h[suit]
      end
    end

    def test_deck_has_4_of_each_value
      h = Hash.new(0)
      @deck.each { |card| h[card.value] += 1 }
      h.each_key do |value|
        assert_equal 4, h[value]
      end
    end
  end
end