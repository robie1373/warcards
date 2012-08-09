module Cardgame
  class Ai
    def initialize
      @stack   = Array.new
      @discard = Array.new
      #attr_accessor :name
      @ai_name = "H.E.L.P.E.R."
       # Set the game difficulty manually for now. Pick a number < 1. Higher is harder. TODO: make this a switch

    end

    def stack
      @stack
    end
    #
    #def stack=(card)
    #  @stack = Array.new
    #  @stack << card
    #end

    def discard
      @discard
    end

    #def empty_discard
    #  @discard = Array.new
    #end

    def name
      @ai_name
    end

    def difficulty_check?(rand_src, difficulty)
      rand_src < difficulty ? TRUE : FALSE
    end
  end
end
