require_relative 'deck'
require_relative 'card'
require_relative 'ai'
require_relative 'player'
require 'ostruct'

module Cardgame
  class Gameplay
    def initialize(args)
      @deck         = args[:deck]
      @player       = args[:player]
      @ai           = args[:ai]
      @player_cards = Array.new
      @ai_cards     = Array.new
    end

    def shuffle
      @deck.shuffle!
    end

    def deal
      while @deck.length > 0
        deck.length.even? ? @player.stack << @deck.pop : @ai.stack << @deck.pop
      end
    end

    def game_over?
      end_game     = Hash.new
      participants = [@player, @ai]
      participants.each_with_index do |participant, index|
        if (participant.stack.length + participant.discard.length) < 1
          participants.delete_at index
          end_game[:winner] = participants.first.name
          end_game[:over?]  = TRUE
        else
          end_game[:over?] = FALSE
        end
      end
      end_game
    end

    def rearm?
      [@ai, @player].each do |participant|
        if participant.stack.length < 1
          participant.discard.each do |card|
            participant.stack << card
          end
          participant.stack.flatten!
          participant.discard.clear
        end
      end
    end

    def contest
      if @ai_cards.last.value > @player_cards.last.value
        winner = @ai
      elsif @ai_cards.last.value < @player_cards.last.value
        winner = @player
      end

      { :winner => winner, :player_cards => @player_cards, :ai_cards => @ai_cards }
    end

    def war?(output = STDOUT)
      while @ai_cards.last.value == @player_cards.last.value
        rearm?
        #TODO make the following line a flag or something so the view code can decide to show it or not.
        output.puts "WAR!!!"
        show_cards
      end
    end

    def show_cards
      player_cards << @player.stack.pop
      ai_cards << @ai.stack.pop
    end

    def discard(result)
      while result[:ai_cards].size > 0
        result[:winner].discard << result[:ai_cards].pop
        result[:winner].discard << result[:player_cards].pop
      end
    end

    def ai
      @ai
    end

    def ai_cards
      @ai_cards
    end

    def deck
      @deck
    end

    def player
      @player
    end

    def player_cards
      @player_cards
    end

  end
end