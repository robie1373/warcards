require_relative '../spec_helper'

module Cardgame
  describe Gameplay do
    def setup
      @deck     = Deck.new
      @player   = Player.new
      @ai       = Ai.new
      @gameplay = Gameplay.new(:deck => @deck, :player => @player, :ai => @ai)
    end

    it "can create a new game" do
      @gameplay.must_be_instance_of Gameplay
    end

    describe "#deck" do
      it "has a deck" do
        @gameplay.deck.must_be_instance_of Deck
      end
    end

    describe "#player" do
      it "has a player" do
        @gameplay.player.must_be_instance_of Player
      end
    end

    describe "#ai" do
      it "has an ai" do
        @gameplay.ai.must_be_instance_of Ai
      end
    end

  end

  describe "dealt deck" do
    def setup
      @deck     = Deck.new
      player    = Player.new
      ai        = Ai.new
      @gameplay = Gameplay.new(:deck => @deck, :player => player, :ai => ai)
      @gameplay.deal
    end

    it "must deal the deck to the player and ai" do
      @gameplay.deck.length.must_equal 0
      @gameplay.player.stack.length.must_equal 26
      @gameplay.player.stack.each { |card| card.must_be_instance_of Card }
      @gameplay.ai.stack.length.must_equal 26
    end

    it "must not duplicate cards between stacks" do
      (@gameplay.ai.stack & @gameplay.player.stack).length.must_equal 0
    end

    it "must not duplicate cards within stacks" do
      (@gameplay.ai.stack | @gameplay.player.stack).length.must_equal 52
    end

    # TODO refactor this test to use specified cards to ensure each case gets tested
    describe "#winner" do
      it "must pick the ai when it has the highest card" do
        @gameplay.ai.stack.clear << (Card.new(:suit => :clubs, :value => 12))
        @gameplay.player.stack.clear << (Card.new(:suit => :hearts, :value => 3))
        @gameplay.show_cards
        @gameplay.winner[:winner].must_equal @gameplay.ai
      end

      it "must pick the player when they have the highest card" do
        @gameplay.ai.stack.clear << (Card.new(:suit => :clubs, :value => 1))
        @gameplay.player.stack.clear << (Card.new(:suit => :hearts, :value => 6))
        @gameplay.show_cards
        @gameplay.winner[:winner].must_equal @gameplay.player
      end
    end

    describe "#discard" do
      it "must give the cards to the ai if it wins" do
        @gameplay.ai.stack.clear << (Card.new(:suit => :clubs, :value => 12))
        @gameplay.player.stack.clear << (Card.new(:suit => :hearts, :value => 3))
        @gameplay.show_cards
        result = @gameplay.winner
        unless result[:winner] == :war
          # TODO get rid of all :war references
          @gameplay.discard(result)
        end
        @gameplay.ai.discard.length.must_equal 2
      end

      it "must give the cards to the player if they win" do
        @gameplay.ai.stack.clear << (Card.new(:suit => :clubs, :value => 4))
        @gameplay.player.stack.clear << (Card.new(:suit => :hearts, :value => 9))
        @gameplay.show_cards
        result = @gameplay.winner
        if result[:winner] != :war
          @gameplay.discard(result)
        end
        @gameplay.player.discard.length.must_equal 2
      end
    end

    describe "#war" do
      it "must play war when there is a draw" do
        card_ai_1     = (Card.new(:suit => :clubs, :value => 5))
        card_ai_2     = (Card.new(:suit => :spades, :value => 4))
        card_ai_3     = (Card.new(:suit => :clubs, :value => 4))
        card_player_1 = (Card.new(:suit => :hearts, :value => 4))
        card_player_2 = (Card.new(:suit => :diamonds, :value => 4))
        card_player_3 = (Card.new(:suit => :hearts, :value => 4))
        @gameplay.ai.stack.clear << card_ai_1
        @gameplay.ai.stack << card_ai_2
        @gameplay.ai.stack << card_ai_3
        @gameplay.player.stack.clear << card_player_1
        @gameplay.player.stack << card_player_2
        @gameplay.player.stack << card_player_3

        @gameplay.show_cards
        result = @gameplay.winner

        result[:ai_cards].must_be_instance_of Array
        result[:ai_cards].last.must_be_instance_of Card
        [card_ai_1, card_ai_2, card_ai_3].each { |card| result[:ai_cards].must_include card }
        [card_player_1, card_player_2, card_player_3].each { |card| result[:player_cards].must_include card }
      end
    end

    describe "#rearm" do
      it "must move discard pile to stack when stack is empty" do
        @gameplay.ai.stack.clear << (Card.new(:suit => :clubs, :value => 12))
        @gameplay.ai.stack << (Card.new(:suit => :hearts, :value => 3))
        @gameplay.player.stack.clear << (Card.new(:suit => :clubs, :value => 4))
        @gameplay.player.stack << (Card.new(:suit => :hearts, :value => 11))

        @gameplay.ai.stack.length.must_equal 2

        2.times do
          @gameplay.show_cards
          @gameplay.discard(@gameplay.winner)
        end

        @gameplay.ai.stack.length.must_equal 0
        @gameplay.player.stack.length.must_equal 0
        @gameplay.ai.discard.length.must_equal 2
        @gameplay.player.discard.length.must_equal 2

        @gameplay.rearm(:participant => @gameplay.ai)
        @gameplay.rearm(:participant => @gameplay.player)

        @gameplay.ai.stack.length.must_equal 2, "ai stack has some cards now"
        @gameplay.player.stack.length.must_equal 2, "player stack has some cards now"

        @gameplay.ai.stack.last.must_be_instance_of Card
        @gameplay.player.stack.last.must_be_instance_of Card

        @gameplay.ai.discard.length.must_equal 0
        @gameplay.player.discard.length.must_equal 0
      end
    end

  end
end