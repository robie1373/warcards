require_relative './spec_helper'

module Cardgame
  describe Game do
    it "must be an instance of Game" do
      Game.new.must_be_instance_of Game
    end

    it "must have a deck of 52 cards at all times" do

      class Game

        def excercise
          @gameplay.game_over?
          @gameplay.rearm?
          @gameplay.show_cards
          @gameplay.war?
          result = @gameplay.contest
          @gameplay.discard(result)
        end

        def sum_cards
          (@gameplay.ai.stack.length + @gameplay.ai.discard.length + @gameplay.player.stack.length + @gameplay.player.discard.length)
        end
      end
      game = Game.new
      5.times do
        game.excercise
        game.sum_cards.must_equal 52
      end
    end


    describe "#player_holdings" do
      def setup
        @game = Game.new
      end

      it "shows how many cards the player has between stack and discard" do
        @game.player_holdings.must_equal 27
      end
    end

    describe "#ai_holdings" do
      def setup
        @game = Game.new
      end

      it "shows how many cards the AI has between the stack and discard" do
        @game.ai_holdings.must_equal 27
      end
    end

    describe "#continue?" do
      def setup
        @game = Game.new
      end

      it "asks if I want to continue" do
        input = StringIO.new("\n")
        output = StringIO.new("")
        @game.continue?(input, output)
        output.string.must_equal "go again?\n"
      end

      it "tells me I ended the game if I say 'n'" do
        input = StringIO.new("n")
        output = StringIO.new("")
        @game.continue?(input, output, :no)
        output.string.must_match /.*You ended the game.*/
      end
    end

    describe "#output_cli" do
      def setup
        @game = Game.new
      end

      it "displays the comparison winner" do
        input = StringIO.new("n")
        output = StringIO.new("")
        skip "setup #gameplay in Game to allow manipulation of game state."
      end

      it "displays the number of cards each participant has" do
        skip "TODO"
      end
    end

  end
end