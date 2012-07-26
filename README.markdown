# Warcards!
## What is it?
Use a deck of flash cards to play the card game war!

Creates a deck of 52 flash cards and assigns them all suits and values.
To win a round you must have the higher card *and* answer the opponents card correctly.
Incorrect answers result in a draw.
The opponent has a scaled-by-difficulty chance to answer your card correctly if it has the higher card.

War is declared when you both have the same value card. To win War, you must answer 2 of your opponent's 3 cards
correctly.

Game ends when one of you is out of cards.

## Implementation concepts
* Keep track of # of right and wrong answers for each flash-card.

* consider using ratio of right/wrong + #times seen to scale how often a flash-card is seen.

* You might make a pool of questions > 52 and select the question for each card out of the pool as it is 'flipped'. Decouple the flash-card from the game card. the game cards are just a token to track game progress.
