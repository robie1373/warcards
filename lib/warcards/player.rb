module Cardgame
  class Player
    def initialize
      @stack = Array.new
      #@stack << Card.new(:suit => :diamonds, :value => 8)
    end

    def stack
      @stack
    end

  end
end