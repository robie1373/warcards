module Cardgame
  class Card
     def initialize(args)
       @suit  = args[:suit]
       @value = args[:value]
     end

     def suit
       @suit
     end

     def value
       @value
     end

   end
end