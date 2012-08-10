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
      50.times do
        game.excercise
        game.sum_cards.must_equal 52
      end
    end
  end
end