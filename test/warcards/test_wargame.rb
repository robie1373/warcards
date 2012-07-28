require_relative '../test_helper'
module Cardgame
  class TestWarCards < MiniTest::Unit::TestCase
    def setup
      @wargame = Wargame.new
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

  end

  class TestDealtDeck < MiniTest::Unit::TestCase
    def setup
      @wargame = Wargame.new
      @wargame.deal
    end

    def test_game_deals_deck
      assert_equal 0, @wargame.deck.length
      assert_equal 26, @wargame.player.stack.length
      @wargame.player.stack.each { |card| assert_instance_of Card, card }
      assert_equal 26, @wargame.ai.stack.length
      # Prove no cards are duplicated between stacks
      assert 0 == (@wargame.ai.stack & @wargame.player.stack).length
      # Prove that no card was duplicated within either stack
      assert 52 == (@wargame.ai.stack | @wargame.player.stack).length
    end

    # TODO refactor this test to use specified cards to ensure each case gets tested
    def test_foray_picks_ai_winner
      @wargame.ai.stack = (Card.new(:suit => :clubs, :value => 12))
      @wargame.player.stack = (Card.new(:suit => :hearts, :value => 3))
      assert_equal @wargame.ai, @wargame.foray.winner[:winner]
    end

    def test_foray_picks_player_winner
      @wargame.ai.stack = (Card.new(:suit => :clubs, :value => 1))
      @wargame.player.stack = (Card.new(:suit => :hearts, :value => 6))
      assert_equal @wargame.player, @wargame.foray.winner[:winner]
    end

    def test_discard_gives_cards_to_ai_if_ai_wins
      @wargame.ai.stack = (Card.new(:suit => :clubs, :value => 12))
      @wargame.player.stack = (Card.new(:suit => :hearts, :value => 3))
      result = @wargame.foray.winner
      unless result[:winner] == :war
        # TODO get rid of all :war references
        @wargame.discard(result)
      end
      assert_equal 2, @wargame.ai.discard.length
    end

    def test_discard_gives_cards_to_player_if_player_wins
      @wargame.ai.stack = (Card.new(:suit => :clubs, :value => 4))
      @wargame.player.stack = (Card.new(:suit => :hearts, :value => 9))
      result = @wargame.foray.winner
      if result[:winner] != :war
        @wargame.discard(result)
      end
      assert_equal 2, @wargame.player.discard.length

    end

    def test_plays_war_when_there_is_a_draw
      card_ai_1 = (Card.new(:suit => :clubs, :value => 5))
      card_ai_2 = (Card.new(:suit => :spades, :value => 4))
      card_ai_3 = (Card.new(:suit => :clubs, :value => 4))
      card_player_1 = (Card.new(:suit => :hearts, :value => 4))
      card_player_2 = (Card.new(:suit => :diamonds, :value => 4))
      card_player_3 = (Card.new(:suit => :hearts, :value => 4))
      @wargame.ai.stack = card_ai_1
      @wargame.ai.stack << card_ai_2
      @wargame.ai.stack << card_ai_3
      @wargame.player.stack = card_player_1
      @wargame.player.stack << card_player_2
      @wargame.player.stack << card_player_3

      result = @wargame.foray.winner

      assert_instance_of Array, result[:ai_cards]
      assert_instance_of Card, result[:ai_cards].last
      assert_includes result[:ai_cards], card_ai_1
      assert_includes result[:ai_cards], card_ai_2
      assert_includes result[:ai_cards], card_ai_3
      assert_includes result[:player_cards], card_player_1
      assert_includes result[:player_cards], card_player_2
      assert_includes result[:player_cards], card_player_3
    end

    def test_discard_is_moved_to_stack_when_stack_is_empty
      @wargame.ai.stack = (Card.new(:suit => :clubs, :value => 12))
      @wargame.ai.stack << (Card.new(:suit => :hearts, :value => 3))
      @wargame.player.stack = (Card.new(:suit => :clubs, :value => 4))
      @wargame.player.stack << (Card.new(:suit => :hearts, :value => 11))

      assert_equal 2, @wargame.ai.stack.length
      2.times do
        @wargame.discard(@wargame.foray.winner)
      end

      assert_equal 0, @wargame.ai.stack.length
      assert_equal 0, @wargame.player.stack.length
      assert_equal 2, @wargame.ai.discard.length
      assert_equal 2, @wargame.player.discard.length

      @wargame.rearm(:participant => @wargame.ai)
      @wargame.rearm(:participant => @wargame.player)

      assert @wargame.ai.stack.length == 2, "ai stack has some cards now"
      assert @wargame.player.stack.length == 2, "player stack has some cards now"

      assert_instance_of Card, @wargame.ai.stack.last
      assert_instance_of Card, @wargame.player.stack.last

      assert_equal 0, @wargame.ai.discard.length
      assert_equal 0, @wargame.player.discard.length
    end

  end

end
