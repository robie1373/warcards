module Cardgame
  class Deck
     include Enumerable

     def initialize
       @deck = Array.new
       [:hearts, :clubs, :diamonds, :spades].each do |suit|
         (1..13).each do |value|
           @deck << Card.new(:suit => suit, :value => value)
         end
       end
     end

     def [](index)
       @deck[index]
     end

     def each &block
       #TODO understand this
       @deck.each { |card| block.call(card) }
     end

     def length
       @deck.length
     end

    def shuffle!
      @deck.shuffle!
    end

    def pop
      @deck.pop
    end
   end
end
