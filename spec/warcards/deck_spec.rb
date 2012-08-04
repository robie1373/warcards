require_relative '../spec_helper'

module Cardgame
  describe Deck do
    def setup
      @deck = Deck.new
    end

    it "must be an instance of deck" do
      @deck.must_be_instance_of Deck
    end

    it "must have 52 cards in it" do
      @deck.length.must_equal 52
    end

    it "must have 13 cards of each suit" do
      h = Hash.new(0)
      @deck.each { |card| h[card.suit] += 1 }
      h.each_key do |suit|
        h[suit].must_equal 13
      end
    end

    it "must have 4 of each value" do
      h = Hash.new(0)
      @deck.each { |card| h[card.value] += 1 }
      h.each_key do |value|
        h[value].must_equal 4
      end
    end

  end
end