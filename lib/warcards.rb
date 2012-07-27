require_relative 'warcards/deck'
require_relative 'warcards/card'
require_relative 'warcards/ai'
require_relative 'warcards/player'
#require 'ap'

module Cardgame
  class Wargame
    def initialize
      @deck = Deck.new
      @player = Player.new
      @ai = Ai.new
    end

    def deal
      @deck.shuffle!
      while @deck.length > 0
        deck.length.even? ? @player.stack << @deck.pop : @ai.stack << @deck.pop
      end
    end

    class Foray
      def initialize (args)
        @player = args[:player]
        @ai = args[:ai]
        @player_card = @player.stack.pop
        @ai_card = @ai.stack.pop
      end

      #def player_card
      #  @player_card
      #end

      #def ai_card
      #  @ai_card
      #end

      def winner
        case
          when @ai_card.value > @player_card.value
            winner = @ai
          when @ai_card.value < @player_card.value
            winner = @player
          when @ai_card.value == @player_card.value
            winner = :war
          else
            raise "Impossible battle. Something is amiss"
        end

        result = {:winner => winner, :player_card => @player_card, :ai_card => @ai_card}
        unless result[:winner] == :war
          discard(result)

        end
        result
      end

      def discard(result)
        result[:winner].discard << result[:ai_card]
        result[:winner].discard << result[:player_card]
      end

    end

    def foray
      Foray.new(:player => @player, :ai => @ai)
    end

    def ai
      @ai
    end

    def deck
      @deck
    end

    def player
      @player
    end

  end
end

__END__

require './warcards'
game = Cardgame::Wargame.new
game.deal
game.player.stack.length
game.foray.winner

# This works
# dudes = [:ai, :player]
# => [:ai, :player]
# dudes.each { |dude| p game.send(dude) }