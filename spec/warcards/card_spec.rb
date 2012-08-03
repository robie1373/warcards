require_relative '../spec_helper'

module Cardgame
  describe Card do
    def setup
      @card = Card.new(:suit => :hearts, :value => 10)
    end

    it "must be an instance of card" do
      @card.must_be_instance_of card
    end

    it "must be created with a given suit" do
      Card.new(:suit => :clubs).suit.must_equal :clubs
    end

    it must "be created with a given value" do
      Card.new(:value => 3).value.must_equal 3
    end

    describe "#suit" do
      it "cards must have a suit" do
        @card.suit.must_equal :hearts
      end
    end

    describe "@value" do
      it "must have a value" do
        @card.value.must_equal 10
      end
    end

  end
end