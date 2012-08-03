require_relative '../spec_helper'

module Cardgame
  describe Wargame do
    def setup
      @wargame = Wargame.new
    end

    it "can create a new game" do
      @wargame.must_be_instance_of Wargame
    end

    describe "#deck" do
      it "has a deck" do
        @wargame.deck.must_be_instance_of Deck
      end
    end

    describe "#player" do
      it "has a player" do
        @wargame.player.must_be_instance_of Player
      end
    end

    describe "#ai" do
      it "has an ai" do
        @wargame.ai.must_be_instance_of Ai
      end
    end

  end

  describe "dealt deck" do
    def setup
      @wargame = Wargame.new
      @wargame.deal
    end

    it "must deal the deck to the player and ai" do
      @wargame.deck.length.must_equal 0
      @wargame.player.stack.length.must_equal 26
      @wargame.player.stack.each { |card| card.must_be_instance_of Card }
      @wargame.ai.stack.length.must_equal 26
    end

    it "must not duplicate cards between stacks" do
      (@wargame.ai.stack & @wargame.player.stack).length.must_equal 0
    end

    it "must not duplicate cards within stacks" do
      (@wargame.ai.stack | @wargame.player.stack).length.must_equal 52
    end

    # TODO refactor this test to use specified cards to ensure each case gets tested
    describe "#winner" do
      it "must pick the ai when it has the highest card" do
        @wargame.ai.stack     = (Card.new(:suit => :clubs, :value => 12))
        @wargame.player.stack = (Card.new(:suit => :hearts, :value => 3))
        @wargame.foray.winner[:winner].must_equal @wargame.ai
      end

      it "must pick the player when they have the highest card" do
        @wargame.ai.stack     = (Card.new(:suit => :clubs, :value => 1))
        @wargame.player.stack = (Card.new(:suit => :hearts, :value => 6))
        @wargame.foray.winner[:winner].must_equal @wargame.player
      end
    end

    describe "#discard" do
      it "must give the cards to the ai if it wins" do
        @wargame.ai.stack     = (Card.new(:suit => :clubs, :value => 12))
        @wargame.player.stack = (Card.new(:suit => :hearts, :value => 3))
        result                = @wargame.foray.winner
        unless result[:winner] == :war
          # TODO get rid of all :war references
          @wargame.discard(result)
        end
        @wargame.ai.discard.length.must_equal 2
      end

      it "must give the cards to the player if they win" do
        @wargame.ai.stack     = (Card.new(:suit => :clubs, :value => 4))
        @wargame.player.stack = (Card.new(:suit => :hearts, :value => 9))
        result                = @wargame.foray.winner
        if result[:winner] != :war
          @wargame.discard(result)
        end
        @wargame.player.discard.length.must_equal 2
      end
    end

    describe "#war" do
      it "must play war when there is a draw" do
        card_ai_1         = (Card.new(:suit => :clubs, :value => 5))
        card_ai_2         = (Card.new(:suit => :spades, :value => 4))
        card_ai_3         = (Card.new(:suit => :clubs, :value => 4))
        card_player_1     = (Card.new(:suit => :hearts, :value => 4))
        card_player_2     = (Card.new(:suit => :diamonds, :value => 4))
        card_player_3     = (Card.new(:suit => :hearts, :value => 4))
        @wargame.ai.stack = card_ai_1
        @wargame.ai.stack << card_ai_2
        @wargame.ai.stack << card_ai_3
        @wargame.player.stack = card_player_1
        @wargame.player.stack << card_player_2
        @wargame.player.stack << card_player_3

        result = @wargame.foray.winner

        result[:ai_cards].must_be_instance_of Array
        result[:ai_cards].last.must_be_instance_of Card
        [card_ai_1, card_ai_2, card_ai_3].each { |card| result[:ai_cards].must_include card }
        [card_player_1, card_player_2, card_player_3].each { |card| result[:player_cards].must_include card }
      end
    end

    describe "#rearm" do
      it "must move discard pile to stack when stack is empty" do
        @wargame.ai.stack = (Card.new(:suit => :clubs, :value => 12))
        @wargame.ai.stack << (Card.new(:suit => :hearts, :value => 3))
        @wargame.player.stack = (Card.new(:suit => :clubs, :value => 4))
        @wargame.player.stack << (Card.new(:suit => :hearts, :value => 11))

        @wargame.stack.length.must_equal 2

        2.times do
          @wargame.discard(@wargame.foray.winner)
        end

        @wargame.ai.stack.length.must_equal 0
        @wargame.player.stack.length.must_equal 0
        @wargame.ai.discard.length.must_equal 2
        @wargame.player.discard.length.must_equal 2

        @wargame.rearm(:participant => @wargame.ai)
        @wargame.rearm(:participant => @wargame.player)

        @wargame.ai.stack.length.must_equal 2, "ai stack has some cards now"
        @wargame.player.stack.length.must_equal 2, "player stack has some cards now"

        @wargame.ai.stack.last.must_be_instance_of Card
        @wargame.player.stack.last.must_be_instance_of Card

        @wargame.ai.discard.length.must_equal 0
        @wargame.player.discard.length.must_equal 0
      end
    end

  end
end