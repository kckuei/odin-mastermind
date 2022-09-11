# odin-mastermind
Toy Mastermind game implemented in console with `ruby`.

### Game Background
* [Game wiki]((https://en.wikipedia.org/wiki/Mastermind_(board_game)))
* [Primer](https://www.youtube.com/watch?v=dMHxyulGrEk)
* [Strategy-1](https://puzzling.stackexchange.com/questions/546/clever-ways-to-solve-mastermind) [Strategy-2](https://en.wikipedia.org/wiki/Mastermind_(board_game)#Worst_case:_Five-guess_algorithm)

### Overview
* The gist:
  * Codemaker picks a pattern (sequence of 4 numbers and duplicates allowed)
  * Codebreaker attempts to guess the pattern (i.e. the numbers and their positions)
* The number of games is decided in advance. For each game, the codebreaker gets up to 10 guesses
* The codemaker gets 1 pt for each guess/row utilized on the board by the codebreaker
* The codemaker provides feedback for each guess by the codebreaker
* Feedback key as follows:
    ● - correct number(color) and position
    ◑ - correct number(color) and incorrect position
    ◌ - incorrect number(color) and position
* Roles are switched at the end of each round such that for any game, computer and player both get to play as maker and breaker.
* Points are tallied after all games concluded to determine a winner

### Example