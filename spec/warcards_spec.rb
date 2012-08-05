require_relative './spec_helper'

module Cardgame
  describe Game do
    it "must be an instance of Game" do
      Game.new.must_be_instance_of Game
    end

    describe "#start" do
      it "initializes a game" do
        Game.new.must_respond_to "start"
      end
    end

    describe "#deal_cards" do
      def setup
        @game = Game.new
        @game.deal_cards

      end

      it "deals the cards when asked to" do
        Game.new.must_respond_to "deal_cards"
      end

      it "results in a proper player stack" do
        @game.player.stack.length.must_equal 26
      end

      it "results in a proper ai stack" do
        @game.ai.stack.length.must_equal 26
      end
    end

    describe "#flip_cards" do
      def setup
        @game              = Game.new
        @game.player.stack = Card.new(:suit => :hearts, :value => 13)
        @game.ai.stack     = Card.new(:suit => :diamonds, :value => 4)
      end

      it "returns 2 cards, 1 from each player" do
        skip
        shown_cards = @game.flip_cards
        shown_cards.length.must_equal 2
      end

      it "results in an empty player stack" do
        skip
        @game.flip_cards
        @game.player.stack.length.must_equal 0
      end

      it "returns cards" do
        skip
        shown_cards = @game.flip_cards
        shown_cards[0].must_be_instance_of Card
      end
    end
  end
end