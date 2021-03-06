require_relative './spec_helper'

module Cardgame
  describe Game do
    it "must be an instance of Game" do
      Game.new.must_be_instance_of Game
    end

    it "must have a deck of 52 cards at all times" do

      class Game

        def excercise
          @gameplay.game_over?
          @gameplay.rearm?
          @gameplay.show_cards
          @gameplay.war?
          result = @gameplay.contest
          @gameplay.discard(result)
        end

        def sum_cards
          (@gameplay.ai.stack.length + @gameplay.ai.discard.length + @gameplay.player.stack.length + @gameplay.player.discard.length)
        end
      end
      game = Game.new
      5.times do
        game.excercise
        game.sum_cards.must_equal 52
      end
    end


    describe "#player_holdings" do
      def setup
        @game = Game.new
      end

      it "shows how many cards the player has between stack and discard" do
        @game.player_holdings.must_equal 27
      end
    end

    describe "#ai_holdings" do
      def setup
        @game = Game.new
      end

      it "shows how many cards the AI has between the stack and discard" do
        @game.ai_holdings.must_equal 27
      end
    end

    #describe "#continue?" do
    #  def setup
    #    @game = Game.new
    #  end
    #
    #  it "asks if I want to continue" do
    #    input = StringIO.new("\n")
    #    output = StringIO.new("")
    #    @game.continue?(input, output)
    #    output.string.must_equal "go again?\n"
    #  end
    #
    #  it "tells me I ended the game if I say 'n'" do
    #    input = StringIO.new("n")
    #    output = StringIO.new("")
    #    @game.continue?(input, output, :no)
    #    output.string.must_match /.*You ended the game.*/
    #  end
    #end

    describe "#output_cli" do
      def setup
        @game = Game.new
        @gameplay = @game.gameplay(deck: Deck.new, player: Player.new, ai: Ai.new)
        @gameplay.ai_cards.clear << (Card.new(:suit => :clubs, :value => 2))
        @gameplay.player_cards.clear << (Card.new(:suit => :clubs, :value => 13))
        @result = @gameplay.contest
        @output = StringIO.new("")
      end

      it "displays the comparison winner" do
        @game.output_cli(@result, @output)
        @output.string.must_match /^Player has the high card\./
      end

      it "displays the number of cards each participant has" do
        @game.output_cli(@result, @output)
        @output.string.must_match /Player has 27 cards.*AI has 27 cards/
      end

      it "shows a graph representation of the deck" do
        @game.output_cli(@result, @output)
        @output.string.must_match /pppppppppppppppppppppppppp|aaaaaaaaaaaaaaaaaaaaaaaaaa/
      end
    end

    describe "#build_graph" do
      def setup
        @game = Game.new
        @gameplay = @game.gameplay(deck: Deck.new, player: Player.new, ai: Ai.new)
        @gameplay.ai_cards.clear << (Card.new(:suit => :clubs, :value => 2))
        @gameplay.player_cards.clear << (Card.new(:suit => :clubs, :value => 13))
        @result = @gameplay.contest
        @output = StringIO.new("")
      end

      it "shows a graph representation of the deck" do
        res = @game.build_graph((@game.player_holdings - 1), (@game.ai_holdings - 1))
        res.must_equal "pppppppppppppppppppppppppp|aaaaaaaaaaaaaaaaaaaaaaaaaa"
      end
    end

    describe "#test_ai" do
      def setup
        @game = Game.new
      end

      it "is true if difficulty is lower than random" do
        @game.test_ai(0.1).must_equal TRUE
      end

      it "if false if difficulty is higher than random" do
        @game.test_ai(0.3, 0.2).must_equal FALSE
      end
    end

    describe "#test_player" do
      def setup
        @questions = Querinator::Game.new.get_questions("spec/test_question_file.txt")
        @input = StringIO.new("\n")
        @output = StringIO.new("")
        @game = Game.new
      end

      it "asks the player a question" do
        @game.test_player(@questions.first, @input, @output)
        @output.string.must_equal "Do you get Tom Servo?\n"
      end

      it "tells me the given answer is incorrect" do
        input = StringIO.new("no I do not")
        @game.test_player(@questions.first, input, @output).must_equal FALSE
      end

      it "tells me the given answer is correct" do
        input = StringIO.new("Nobody does. I'm the wind baby.")
        @game.test_player(@questions.first, input, @output).must_equal TRUE
      end
    end

    describe "#challenge_player" do
      def setup
        @game = Game.new
        @questions = Querinator::Game.new.get_questions("spec/test_question_file.txt")
        @gameplay = @game.gameplay(deck: Deck.new, player: Player.new, ai: Ai.new)
        @gameplay.ai_cards.clear << (Card.new(:suit => :clubs, :value => 2))
        @gameplay.player_cards.clear << (Card.new(:suit => :clubs, :value => 13))
        @result = @gameplay.contest
        @output = StringIO.new("")
      end

      it "congratulates me when I get it correct" do
        input = StringIO.new("Nobody does. I'm the wind baby.\n")
        @game.challenge_player(@result, @questions.first, input, @output)
        @output.string.split("\n").last.must_equal "Correct! Yay!"
      end

      it "consoles me when I get it wrong" do
        input = StringIO.new("Who's Tom Servo?\n")
        @game.challenge_player(@result, @questions.first, input, @output)
        @output.string.split("\n").last.must_match /^Oooh\. I'm sorry/
      end

      #it "asks me if I want to continue" do
      #  input = StringIO.new("Who's Tom Servo?\n\n")
      #  @game.challenge_player(@result, @questions.first, input, @output)
      #  @output.string.split("\n").last.must_match /go again\?/
      #end
    end

    describe "#challenge_ai" do
      def setup
        @game = Game.new
        @gameplay = @game.gameplay(deck: Deck.new, player: Player.new, ai: Ai.new)
        @gameplay.ai_cards.clear << (Card.new(:suit => :clubs, :value => 12))
        @gameplay.player_cards.clear << (Card.new(:suit => :clubs, :value => 3))
        @result = @gameplay.contest
        @output = StringIO.new("")
      end

      it "tells me the ai lost" do
        @game.challenge_ai(@result, @output, 0.9)
        @output.string.must_equal "Ai was wrong. Player became the winner!\n"
      end

      it "tells me the ai won" do
        @game.challenge_ai(@result, @output, 0.1)
        @output.string.must_equal "Ai was correct. Ai wins the round.\n"
      end
    end

    def challenge_partic_setup(args)
      @game = Game.new
      @questions = Querinator::Game.new.get_questions("spec/test_question_file.txt")
      @gameplay = @game.gameplay(deck: Deck.new, player: Player.new, ai: Ai.new)
      @gameplay.ai_cards.clear << (args[:ai_card])
      @gameplay.player_cards.clear << (args[:player_card])
      @result = @gameplay.contest
      @output = StringIO.new("")
      @input = StringIO.new("incorrect answer\n")
    end

    describe "#challenge_participants player" do
      def setup
        challenge_partic_setup(:ai_card => Card.new(:suit => :clubs, :value => 2), :player_card => Card.new(:suit => :clubs, :value => 11))
      end

      it "calls #challenge_player if player has high card" do
        @game.challenge_participants(@result, @questions.first, @input, @output, 0.1)
        @output.string.must_match /#{@questions.first.pose}/
      end
    end

    describe "#challenge_participants ai" do
      def setup
        challenge_partic_setup(:ai_card => Card.new(:suit => :clubs, :value => 12), :player_card => Card.new(:suit => :clubs, :value => 1))
      end

      it "calls #challenge_ai if ai has high card" do
        result = @gameplay.contest
        @game.challenge_participants(result, @questions.first, @input, @output, 0.1)
        @output.string.must_match /Ai was correct\. Ai wins the round\.\n/
      end
    end

    describe "#get_filename" do
      def setup
        @output = StringIO.new("")
        @input = StringIO.new("incorrect answer\n")
        @game = Game.new
      end

      it "displays the path of the sample question file" do
        @game.get_filename(@input, @output)
        @output.string.must_match "spec/test_question_file.txt"
      end

      it "returns an absolute path if a path is passed in" do
        input = StringIO.new("~/.bash_history\n")
        @game.get_filename(input, @output).must_match ".bash_history"
      end

      it "returns the path to the sample question if the user hits enter" do
        input = StringIO.new("\n")
        @game.get_filename(input, @output).must_equal "spec/test_question_file.txt"
      end
    end
  end


end