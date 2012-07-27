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

  end
end
