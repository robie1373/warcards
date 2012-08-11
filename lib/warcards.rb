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
      @output = Struct.new(:winner, :player_feedback, :ai_feedback, :posed)

    end

    ##def output
    ##  @output
    ##end
    ##
    ##def rearm?
    ##  @gameplay.rearm?
    ##end
    ##
    ##def show_cards
    ##  @gameplay.show_cards
    ##end
    ##
    ##def war?
    ##  @gameplay.contest
    ##end
    ##
    ##def contest
    ##  @gameplay.contest
    ##end
    ##
    ##def discard(result)
    ##  @gameplay.discard(result)
    ##end
    ##
    ##def game_over?
    ##  @gameplay.game_over?
    ##end
    #
    #def player
    #  @player
    #end
    #
    #def ai
    #  @ai
    #end

    def run
      filename = get_filename
      until File.file? filename
        get_filename
      end
      @questions = Querinator::Game.new.get_questions(filename)
      loop do
        @gameplay.game_over?
        @gameplay.rearm?
        @gameplay.show_cards
        @gameplay.war?
        result = @gameplay.contest

        output_cli(result)

        continue?
        @gameplay.discard(result)
      end
    end

    def get_filename
      puts "What question file?\nfilename: "
      filename = gets.chomp
      file     = File.expand_path(filename)
      p file
      file
    end

    def continue?
      puts "go again?\n"
      next_round = gets
      if next_round.downcase.chomp.include? "n"
        puts "You ended the game"
        exit
      end
    end

    def output_cli(result)
      puts "#{result[:winner].name} won"
      puts "Player has #{player_holdings} cards.\tAI has #{ai_holdings} cards."
      challenge_participants(result)
    end

    def player_holdings
      (@gameplay.player.stack.length + @gameplay.player.discard.length + 1)
    end

    def ai_holdings
      @gameplay.ai.stack.length + @gameplay.ai.discard.length + 1
    end

    def challenge_participants(result)
      if result[:winner] == @gameplay.player
        challenge_player(result)
      else
        challenge_ai(result)
      end
    end

    def challenge_ai(result)
      if test_ai
        puts "Ai was correct."
      else
        puts "Ai was wrong. #{@gameplay.player.name} became the winner!"
        result[:winner] = @gameplay.player
      end
    end

    def challenge_player(result)
      if test_player
        puts "Correct! Yay!"
      else
        puts "Oooh. I'm sorry. The correct answer was 'TODO'. #{@gameplay.ai.name} became the winner."
        result[:winner] = @gameplay.ai
      end
    end


    def test_player
      question = @questions.sample
      puts question.pose
      answer = gets
      question.is_correct?(answer.chomp)
    end

    def test_ai(difficulty)
      difficulty ||= 0.4
      @ai.difficulty_check?(rand, difficulty)
    end

  end
end
