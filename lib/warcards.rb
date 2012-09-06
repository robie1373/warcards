require_relative 'warcards/gameplay'
require 'querinator'

module Cardgame
  class Game
    def initialize
      @deck = Deck.new
      @player = Player.new
      @ai = Ai.new
      @gameplay = gameplay(:deck => @deck, :player => @player, :ai => @ai)
      @gameplay.shuffle
      @gameplay.deal
      @output = Struct.new(:winner, :player_feedback, :ai_feedback, :posed)

    end

    # TODO finish this up to make #output_cli tests easier
    def gameplay(args)
      deck = args[:deck]
      player = args[:player]
      ai = args[:ai]
      Gameplay.new(:deck => deck, :player => player, :ai => ai)
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
        end_game = @gameplay.game_over?

        if end_game[:over?]
          puts "Game over #{end_game[:winner]} won!"
          exit
        else
          @gameplay.rearm?
          @gameplay.show_cards
          @gameplay.war?
          result = @gameplay.contest
          output_cli(result)
          continue?
          @gameplay.discard(result)
        end
      end
    end

    def get_filename
      puts(Dir.glob "**/*.txt")
      sample_questions = "spec/test_question_file.txt"
      puts "What question file?\n(Just hit enter to use the sample questions.)\nfilename: "
      filename = gets.chomp
      if File.file?(File.expand_path(filename))
        File.expand_path(filename)
      else
        sample_questions
      end
    end

    def continue?(input = STDIN, output = STDOUT, really_end = :yes)
      output.puts("go again?\n")
      next_round = input.gets
      if next_round.downcase.chomp.include? "n"
        output.puts "You ended the game"
        if really_end == :yes
          exit
        end
      end
    end

    def output_cli(result, output = STDOUT)
      output.puts "#{result[:winner].name} won"
      output.puts "Player has #{player_holdings} cards.\tAI has #{ai_holdings} cards."
      challenge_participants(result)
      # TODO get challenge_participants out of here. No longer belongs. Causing hard tests.
    end

    def player_holdings
      # When this is run there is one card from each participant in play.
      # That is what the +1 compensates for and why the test looks wack.
      (@gameplay.player.stack.length + @gameplay.player.discard.length + 1)
    end

    def ai_holdings
      # When this is run there is one card from each participant in play.
      # That is what the +1 compensates for and why the test looks wack.
      (@gameplay.ai.stack.length + @gameplay.ai.discard.length + 1)
    end

    def challenge_participants(result, question = @questions.sample, input = STDIN, output = STDOUT, rnd_src = rand)
      if result[:winner] == @gameplay.player
        challenge_player(result, question, input, output)
      else
        challenge_ai(result, output, rnd_src)
      end
    end

    def challenge_ai(result, output = STDOUT, rnd_src = rand)
      if test_ai(rnd_src)
        output.puts "Ai was correct."
      else
        output.puts "Ai was wrong. #{@gameplay.player.name} became the winner!"
        result[:winner] = @gameplay.player
      end
    end

    def challenge_player(result, question = @questions.sample, input = STDIN, output = STDOUT)
      #question = @questions.sample
      if test_player(question, input, output)
        output.puts "Correct! Yay!"
      else
        output.puts %Q{Oooh. I'm sorry. The correct answer was "#{question.answer}". #{@gameplay.ai.name} became the winner.}
        result[:winner] = @gameplay.ai
      end
    end

    def test_player(question, input = STDIN, output = STDOUT)
      output.puts question.pose
      answer = input.gets
      question.is_correct?(answer.chomp)
    end

    def test_ai(rand_src = rand, difficulty = 0.4)
      @ai.difficulty_check?(rand_src, difficulty)
    end

  end
end
