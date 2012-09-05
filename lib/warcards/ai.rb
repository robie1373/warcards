module Cardgame
  class Ai
    def initialize
      @stack   = Array.new
      @discard = Array.new
      #attr_accessor :name
      @ai_name = "H.E.L.P.E.R."
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
