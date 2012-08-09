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
* #deal - shuffles the deck _and_ distributes them between participants.
    * _Is this Deck behavior?_ `@deck.shuffle.deal(@player, @ai)`
* #rearm - Moves discard to stack when stack is empty. good.
* Foray _should this be contained in the Gameplay class?_
    * #winner - determines the winning package by comparing card.value _and_ checks to see if rearm is needed _and_ rearms
    if needed.
    * #war - effectively an alias for #show_cards _This is probably redundant unless the test for war is moved into this 
    function providing something like_ `while war?`
* #self.show_cards - Pops a card from the deck of each participant into their 'hand'. Good.
* #discard - places the contested cards into the winner's discard based on the package from #winner. Good.
* #foray - Instantiates Foray with an instance of the contestants. Good if Foray makes sense.
* #ai - Wrapper for ai attr_accessor
* #deck - wrapper for deck attr_accessor
* #player - wrapper for player attr_accessor

## Warcards Game
* #start - TODO
* #deal_cards - wrapper for Gameplay#deal
* #flip_cards - TODO
* #player - wrapper for attr_accessor
* #ai - wrapper for ai attr_accessor
    