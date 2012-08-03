require_relative '../spec_helper'

module Cardgame
  describe Player do
    def setup
      @wargame = Wargame.new
      @player = wargame.player
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
        player.name.must_equal "Player"
      end
    end

  end
end