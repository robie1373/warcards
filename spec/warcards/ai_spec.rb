require_relative '../spec_helper'

module Cardgame
  describe Ai do
    def setup
      @wargame = Wargame.new
      @ai = @wargame.ai
      @wargame.deal
    end

    describe "#ai" do
      it "must be an instance of Ai" do
      @ai.must_be_instance_of Ai
      end

      it "must have a stack of Card objects" do
        @ai.stack.first.must_be_instance_of Card
      end

      it "must have a name" do
        @wargame.ai.name.must_equal "H.E.L.P.E.R."
      end
    end

  end
end