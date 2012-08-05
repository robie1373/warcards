require 'bundler/setup'
Bundler.require(:default)
require_relative 'warcards/gameplay'
require 'querinator'

module Cardgame
  class Game
    def initialize
      @deck = Deck.new
      @player = Player.new
      @ai = Ai.new
      @gameplay = Gameplay.new(:deck => @deck, :player => @player, :ai => @ai)
    end

    def start

    end

    def deal_cards
      @gameplay.deal
    end

    def flip_cards
      #@gameplay.
    end

    def player
      @player
    end

    def ai
      @ai
    end
  end
end
