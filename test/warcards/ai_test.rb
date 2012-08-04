require_relative '../test_helper'
module Cardgame
  class TestAi < MiniTest::Unit::TestCase
    def setup
      @wargame = Wargame.new
      @ai = @wargame.ai
    end

    def test_ai
      assert_instance_of Ai, @ai
    end

    def test_ai_has_stack_of_cards
      @wargame.deal
      assert_instance_of Card, @ai.stack.first
    end

    def test_ai_has_a_name
      assert_equal "H.E.L.P.E.R.", @wargame.ai.name
    end
  end
end