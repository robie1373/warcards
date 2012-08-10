# Responsibilities

## Ai - Describes the Ai participant
* #name - good
* #difficulty_check - Ai specific. good.
* #stack - wrapper for instance variable holding an array
* #discard - wrapper for instance variable holding an array

## Player - Describes the player participant
* #name - good
* #stack - wrapper for instance variable holding an array
* #discard - wrapper for instance variable holding an array
* _Should this just be a Struct? There is no behavior._

## Deck - Allows manipulation of all 52 cards.
* #[] - allows indexing. good.
* #each - good.
* #length - good
* #shuffle - good
* #pop - good

## Card - Contains information about a card
* #suit - good.
* #value - good.
* _Should this just be a Struct? There is no behavior._

## Gameplay - Handles logic of playing the game
* #shuffle - shuffles the deck
* #deal - distributes them between participants.
    * _Is this Deck behavior?_ `@deck.shuffle.deal(@player, @ai)` _No. Some decks might not get shuffled or dealt.
    Those are implementation details of various types of gameplay. This belongs in gameplay._
* #rearm? - rearms participant if required
* #winner - determines the winning package by comparing card.value
* #war? - runs a war as long as needed
* #show_cards - Pops a card from the deck of each participant into their 'hand'. Good.
* #discard - places the contested cards into the winner's discard based on the package from #winner. Good.
* #game_over? - ends game when a participant is out of cards
* #ai - Wrapper for ai attr_accessor
* #deck - wrapper for deck attr_accessor
* #player - wrapper for player attr_accessor

## Warcards Game
* #initialize - create a new instance of game in a playable condition. This means. creating player, ai, deck and running #shuffle and #deal
* a game of war looks like this:
    * #game_over?
    * #rearm?
    * #showcards
    * #war?
    * #winner
    * #discard
    * repeat until someone wins.
* #start - TODO
* #deal_cards - wrapper for Gameplay#deal
* #flip_cards - TODO
* #player - wrapper for attr_accessor
* #ai - wrapper for ai attr_accessor
    