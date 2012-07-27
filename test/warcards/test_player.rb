require_relative '../test_helper'
module Cardgame
  class TestPlayer < MiniTest::Unit::TestCase
    def setup
      @wargame = Wargame.new
      @player  = @wargame.player
    end

    def test_player
      assert_instance_of Player, @player
    end

    def test_player_has_stack_of_cards
      @wargame.deal
      assert_instance_of Card, @player.stack.first
    end
  end
end