#module Cardgame
=begin
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
=end