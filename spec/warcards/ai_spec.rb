require_relative '../spec_helper'

module Cardgame
  describe Ai do
    def setup
      @wargame = Wargame.new
      @ai      = @wargame.ai
      @wargame.deal
    end

    it "must be an instance of Ai" do
      @ai.must_be_instance_of Ai
    end

    describe "#stack" do
      it "must have a stack of Card objects" do
        @ai.stack.first.must_be_instance_of Card
      end
    end

    describe "#name" do
      it "must have a name" do
        @wargame.ai.name.must_equal "H.E.L.P.E.R."
      end
    end

    describe "#difficulty_check?" do
      it "must test against the difficult level to see if it wins a round" do
        rand_src = 0.1
        difficulty = 0.4
        @wargame.ai.difficulty_check?(rand_src, difficulty).must_equal TRUE
      end
    end

  end
end
