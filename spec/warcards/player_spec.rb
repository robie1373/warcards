require_relative '../spec_helper'

module Cardgame
  describe Player do
    def setup
      @deck = Deck.new
      @player = Player.new
      @ai = Ai.new
      @gameplay = Gameplay.new(:deck => @deck, :player => @player, :ai => @ai)
      @player = @gameplay.player
      @gameplay.deal
    end

    it "must be an instance of Player" do
      @player.must_be_instance_of Player
    end

    describe "#stack" do
      it "player must have a stack of cards" do
        @player.stack.first.must_be_instance_of Card
      end
    end

    describe "#name" do
      it "player must have a name" do
        @player.name.must_equal "Player"
      end
    end

  end
end