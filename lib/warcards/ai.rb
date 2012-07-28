module Cardgame
  class Ai
    def initialize
      @stack = Array.new
      @discard = Array.new
    end

    def stack
      @stack
    end

    def stack=(card)
      @stack = Array.new
      @stack << card
    end

    def discard
      @discard
    end

    def empty_discard
      @discard = Array.new
    end

    def name
      'H.E.L.P.E.R.'
    end

  end
end
