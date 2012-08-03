require 'bundler/setup'
Bundler.require(:default)
require_relative 'warcards/wargame'
require 'querinator'

module Cardgame
  game = Wargame.new
  game.deal

  round = 1
  #pca = []
  #aca = []
  pch = Hash.new(0)
  ach = Hash.new(0)

  def self.get_questions
    file_name = "./test_question_file.txt"
    Querinator::Importer.new.parse(file_name)
  end

  questions = get_questions
  #p questions.sample

  def self.compile(stat, stat_hash)
    stat_hash[stat] += 1
  end

  puts "Let's get this started."
  while gets
    if game.ai.stack.length == 1
      game.rearm(:participant => game.ai)
    elsif game.player.stack.length == 1
      game.rearm(:participant => game.player)
    else
      result = game.foray.winner
      question = questions.sample

      game.discard(result)
      if (result[:ai_cards].length + result[:player_cards].length) > 2
        puts "\n"
        puts '*@# There Was a WAR!! #@*'
        puts "\n"
    end
      puts "-----------------------------------------------------------"
      puts "Round #{round}: #{result[:winner].name} won."
      puts "Player card was #{result[:player_cards].last.value} of #{result[:player_cards].last.suit}. #{game.player.name} has #{game.player.stack.length} cards in the stack and #{game.player.discard.length} cards on the discard"
      puts "AI card was #{result[:ai_cards].last.value} of #{result[:ai_cards].last.suit}. #{game.ai.name} has #{game.ai.stack.length} cards in the stack and #{game.ai.discard.length} cards on the discard"
      puts ""
      p question.pose
      reply = gets
      reply = reply.chomp
      if question.is_correct?(reply)
        puts "That's right!!"
      else
        puts "Ooooh. I'm sorry. The correct answer is '#{question.answer}'"
      end
      round += 1
      #pca = game.player.stack.length + game.player.discard.length
      #aca = game.ai.stack.length + game.ai.discard.length
      #foo = compile(pca, pch)
      #foo = compile(aca, ach)
      #puts "Player holdings distribution [holdings, #of times seen]: #{p pch.sort_by { |key, value| key }}"
      #puts ""
      #puts "AI holdings distribution: #{p ach.sort_by {|key, value| key}}"
    end
  end
end
