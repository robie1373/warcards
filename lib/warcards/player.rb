module Cardgame
  class Player
    def initialize
      @stack = Array.new
      @discard = Array.new
      @player_name = "Player"
    end

    def stack
      @stack
    end

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
      @player_name
    end
  end
end
