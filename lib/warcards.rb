require 'bundler/setup'
Bundler.require(:default)
require_relative 'warcards/gameplay'
require 'querinator'

module Cardgame
  class Game
    def initialize
      @deck     = Deck.new
      @player   = Player.new
      @ai       = Ai.new
      @gameplay = Gameplay.new(:deck => @deck, :player => @player, :ai => @ai)
      @gameplay.shuffle
      @gameplay.deal
    end

    def run
      loop do
        @gameplay.game_over?
        @gameplay.rearm?
        @gameplay.show_cards
        @gameplay.war?
        result = @gameplay.winner
        puts "#{result[:winner].name} won"
        puts "Player has #{@gameplay.player.stack.length + @gameplay.player.discard.length} cards.\tAI has #{@gameplay.ai.stack.length + @gameplay.ai.discard.length} cards."
        puts "go again?\n"
        next_round = gets
        if next_round.downcase.chomp.include? "n"
          puts "You ended the game"
          exit
        end
        @gameplay.discard(result)
      end
    end

    def start
      # TODO
    end

    #def deal_cards
    #  @gameplay.deal
    #end
    #
    #def flip_cards
    #  TODO
    #  @gameplay.
    #end
    #
    #def player
    #  @player
    #end
    #
    #def ai
    #  @ai
    #end
  end
end
