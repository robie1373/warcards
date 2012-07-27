require_relative 'test_helper'
module Cardgame
  class TestWarCards < MiniTest::Unit::TestCase
    def setup
      @wargame = Wargame.new
      @ai = Ai.new
      @player = Player.new
    end

    def test_game_can_be_created
      assert_instance_of Wargame, @wargame
    end

    def test_game_includes_a_deck
      assert_instance_of Deck, @wargame.deck
    end

    def test_game_includes_a_player
      assert_instance_of Player, @wargame.player
    end

    def test_game_includes_an_ai
      assert_instance_of Ai, @wargame.ai
    end

    def test_game_deals_deck
      @wargame.deal
      assert_equal 0, @wargame.deck.length
      assert_equal 26, @wargame.player.stack.length
      @wargame.player.stack.each { |card| assert_instance_of Card, card }
      assert_equal 26, @wargame.ai.stack.length
      # Prove no cards are duplicated between stacks
      assert 0 == (@wargame.ai.stack & @wargame.player.stack).length
      # Prove that no card was duplicated within either stack
      assert 52 == (@wargame.ai.stack | @wargame.player.stack).length
    end

    def test_foray_picks_top_cards_from_stack
      assert_equal @wargame.player.stack[0], @wargame.foray.player_card
      assert_equal @wargame.ai.stack[0], @wargame.foray.ai_card
    end

    class TestWarCards < MiniTest::Unit::TestCase
      def setup
        @wargame = Wargame.new
        @wargame.deal
      end

    def test_foray_picks_right_winner
      #@wargame.deal
      26.times do
        case
          when @wargame.ai.stack.last.value > @wargame.player.stack.last.value
            assert_equal @wargame.ai, @wargame.foray.winner[:winner]
          when @wargame.ai.stack.last.value < @wargame.player.stack.last.value
            assert_equal @wargame.player, @wargame.foray.winner[:winner]
          when @wargame.ai.stack.last.value == @wargame.player.stack.last.value
            assert_equal :war, @wargame.foray.winner[:winner]
        end
      end
    end

    def test_foray_puts_winnings_into_discard
      #@wargame.deal
      ai_disc_size = 0
      player_disc_size = 0
      26.times do
        if @wargame.foray.winner[:winner] == @wargame.ai
          ai_disc_size += 2
          assert_equal 2, @wargame.ai.discard.length
          assert_instance_of Card, @wargame.ai.discard.first
        elsif @wargame.foray.winner[:winner] == @wargame.player
          player_disc_size += 2
          assert_equal 2, @wargame.player.discard.length
          assert_instance_of Card, @wargame.player.discard.first
        else
          "it was a draw"
          assert TRUE == FALSE
        end
      end
    end

   end
  end
end