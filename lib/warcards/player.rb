module Cardgame
  class Player
    def initialize
      @stack = Array.new
      @discard = Array.new
      #@stack << Card.new(:suit => :diamonds, :value => 8)
    end

    def stack
      @stack
    end

    def stack=(card)
      @stack = Array.new
      @stack << [card]
    end

    def discard
      @discard
    end

  end
end