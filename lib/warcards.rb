require_relative 'warcards/deck'
require_relative 'warcards/card'
require_relative 'warcards/ai'
require_relative 'warcards/player'

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

    def rearm(args)
      args[:participant].discard.each do |card|
        args[:participant].stack << card
      end
      args[:participant] = Array.new
    end

    class Foray
      def initialize (args)
        @player = args[:player]
        @ai = args[:ai]
        @player_cards = Array.new
        @ai_cards = Array.new
        show_cards
      end

      def winner
        while @ai_cards.last.value == @player_cards.last.value
          war
        end

        if @ai_cards.last.value > @player_cards.last.value
          winner = @ai
        elsif @ai_cards.last.value < @player_cards.last.value
          winner = @player
        end

        {:winner => winner, :player_cards => @player_cards, :ai_cards => @ai_cards}
      end

      def show_cards
        @player_cards << @player.stack.pop
        @ai_cards << @ai.stack.pop
      end

      def war
        show_cards
      end


    end

    def discard(result)
      result[:winner].discard << result[:ai_cards]
      result[:winner].discard << result[:player_cards]
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
