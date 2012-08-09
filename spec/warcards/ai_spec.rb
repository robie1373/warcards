require_relative '../spec_helper'

module Cardgame
  describe Ai do
    #def setup
      #deck     = Deck.new
      #player   = Player.new
      #ai       = Ai.new
      #@gameplay = Gameplay.new(:deck => deck, :player => player, :ai => Ai.new)
      #@ai       = @gameplay.ai
      #@gameplay.deal
    #end

    it "must be an instance of Ai" do
      Ai.new.must_be_instance_of Ai
    end

    describe "#stack" do
      def setup
        @ai = Ai.new
        card = Card.new(:suit => :spades, :value => 5)
        @ai.stack << card
      end

      it "must have a stack of Card objects" do
        @ai.stack.first.must_be_instance_of Card
      end

      it "must be able to append cards on the end" do
        original_stack_length = @ai.stack.length
        @ai.stack << Card.new(:suit => :spades, :value => 7)
        @ai.stack.length.must_equal (original_stack_length + 1)
      end
    end

    describe "#discard" do
      def setup
        @ai = Ai.new
        @ai.discard << Card.new(:suit => :clubs, :value => 11)
      end

      it "must have a discard of Card objects" do
        @ai.discard.first.must_be_instance_of Card
      end

      it "must be able to append cards on the end" do
        original_discard_length = @ai.discard.length
        @ai.discard << Card.new(:suit => :spades, :value => 7)
        @ai.discard.length.must_equal (original_discard_length + 1)
      end
    end

    describe "#name" do
      it "must have a name" do
        Ai.new.name.must_equal "H.E.L.P.E.R."
      end
    end

    describe "#difficulty_check?" do
      it "must test against the difficult level to see if it wins a round" do
        rand_src   = 0.1
        difficulty = 0.4
        Ai.new.difficulty_check?(rand_src, difficulty).must_equal TRUE
      end
    end

  end
end
