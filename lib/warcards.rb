require 'bundler/setup'
Bundler.require(:default)
require_relative 'warcards/gameplay'
require 'querinator'

module Cardgame
  class Game
    def initialize
      @questions = Querinator::Game.new.get_questions
      @deck      = Deck.new
      @player    = Player.new
      @ai        = Ai.new
      @gameplay  = Gameplay.new(:deck => @deck, :player => @player, :ai => @ai)
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
        if result[:winner] == @gameplay.player
          if test_player
            puts "Correct! Yay!"
          else
            puts "Oooh. I'm sorry. The correct answer was 'TODO'. #{@gameplay.ai.name} became the winner."
            result[:winner] = @gameplay.ai
          end
        else
          if test_ai
            puts "Ai was correct."
          else
            puts "Ai was wrong. #{@gameplay.player.name} became the winner!"
            result[:winner] = @gameplay.player
          end
        end
        continue?
        @gameplay.discard(result)
      end
    end

    def continue?
      puts "go again?\n"
      next_round = gets
      if next_round.downcase.chomp.include? "n"
        puts "You ended the game"
        exit
      end
    end

    def test_player
      question = @questions.sample
      puts question.pose
      answer = gets
      question.is_correct?(answer.chomp)
    end

    #TODO make this configurable
    def test_ai
      @ai.difficulty_check?(rand, 0.9)
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
