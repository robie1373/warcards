require_relative 'deck'
require_relative 'card'
require_relative 'ai'
require_relative 'player'

module Cardgame
  class Gameplay
    def initialize(args)
      @deck         = args[:deck]
      @player       = args[:player]
      @ai           = args[:ai]
      @player_cards = Array.new
      @ai_cards     = Array.new
    end

    def deal
      @deck.shuffle!
      while @deck.length > 0
        deck.length.even? ? @player.stack << @deck.pop : @ai.stack << @deck.pop
      end
    end

    def rearm(args)
      p args[:participant]
      args[:participant].discard.each do |card|
        args[:participant].stack << card
      end
      args[:participant].stack.flatten!
      args[:participant].discard.clear
    end

    def winner
      #begin
        while @ai_cards.last.value == @player_cards.last.value
          war
        end
     # rescue
     #   if @ai.stack.length < 1
     #     rearm(:participant => @ai)
     #   elsif @player.stack.length < 1
     #     rearm(:participant => @player)
     #   else
     #     raise "Something went wrong during war.
     #Someone may be too low on ammunition.
     #I'm sorry your war didn't work out."
     #   end
     # end

      if @ai_cards.last.value > @player_cards.last.value
        winner = @ai
      elsif @ai_cards.last.value < @player_cards.last.value
        winner = @player
      end

      { :winner => winner, :player_cards => @player_cards, :ai_cards => @ai_cards }
    end

    def war
      show_cards
    end


    #TODO make sure to do this someplace -> show_cards


    def show_cards
      @player_cards << @player.stack.pop
      @ai_cards << @ai.stack.pop
    end

    def discard(result)
      puts "result is: #{result}"
      result[:winner].discard << result[:ai_cards]
      result[:winner].discard << result[:player_cards]
      puts "winner discard is: #{result[:winner].discard}"
      @player_cards.clear
      @ai_cards.clear
    end

    #def foray
    #  Foray.new(:player => @player, :ai => @ai)
    #end

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