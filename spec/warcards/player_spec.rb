require_relative '../spec_helper'

module Cardgame
  describe Player do
    #def setup
      #@deck = Deck.new
      #@player = Player.new
      #@player = Player.new
      #@gameplay = Gameplay.new(:deck => @deck, :player => @player, :ai => @ai)
      #@player = @gameplay.player
      #@gameplay.deal
    #end

    it "must be an instance of Player" do
      Player.new.must_be_instance_of Player
    end

    describe "#stack" do
      def setup
        @player = Player.new
        card = Card.new(:suit => :hearts, :value => 6)
        @player.stack << card
      end
      it "player must have a stack of cards" do
        @player.stack.first.must_be_instance_of Card
      end
    end
    describe "#discard" do
          def setup
            @player = Player.new
            @player.discard << Card.new(:suit => :clubs, :value => 11)
          end

          it "must have a discard of Card objects" do
            @player.discard.first.must_be_instance_of Card
          end

          it "must be able to append cards on the end" do
            original_discard_length = @player.discard.length
            @player.discard << Card.new(:suit => :spades, :value => 7)
            @player.discard.length.must_equal (original_discard_length + 1)
          end
        end

    describe "#name" do
      it "player must have a name" do
        Player.new.name.must_equal "Player"
      end
    end

  end
end