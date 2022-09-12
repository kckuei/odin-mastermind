# odin-mastermind
Toy Mastermind command line game implemented with `ruby`.

### Game Background
* [Game wiki]((https://en.wikipedia.org/wiki/Mastermind_(board_game)))
* [Primer](https://www.youtube.com/watch?v=dMHxyulGrEk)
* [Strategy-1](https://puzzling.stackexchange.com/questions/546/clever-ways-to-solve-mastermind)
* [Strategy-2](https://en.wikipedia.org/wiki/Mastermind_(board_game)#Worst_case:_Five-guess_algorithm)

### Overview
* The gist:
  * Codemaker picks a pattern (sequence of 4 numbers with digits between 0 and 4, and duplicates allowed)
  * Codebreaker attempts to guess the pattern (i.e. the numbers and their positions)
* The number of games is decided in advance. For each game, the codebreaker gets up to 10 guesses
* The codemaker gets 1 pt for each guess/row utilized on the board by the codebreaker
* The codemaker provides feedback for each guess by the codebreaker
* Feedback key as follows:
    ● - correct number(color) and position
    ◑ - correct number(color) and incorrect position
    ◌ - incorrect number(color) and position
* Roles are switched each round so computer and player plays both codemaker and codebreaker.
* Points are tallied across all games to determine the winner

### Example

```
         AN
░█▀█░█▀▄░▀█▀░█▀█░░░█▀█░█▀▄░█▀█░█▀▄░█░█░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀
░█░█░█░█░░█░░█░█░░░█▀▀░█▀▄░█░█░█░█░█░█░█░░░░█░░░█░░█░█░█░█░▀▀█
░▀▀▀░▀▀░░▀▀▀░▀░▀░░░▀░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀
                                    PRESENTS



███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗██████╗
████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗
██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║██║  ██║
██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██║  ██║
██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██████╔╝
╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═════╝
                                                   CODE-BREAKERS VERSUS CODE-MAKERS




Enter any key to continue.  

How many rounds do you want to play (at least 1 round)?  1

User has selected to play 1 rounds. Enter any key to continue.

============ START ROUND 0 ============ 

CODEMAKER (CPU) has selected a pattern: * * * * 

CODEBREAKER (PLAYER): Make a guess.
Choose a 4-digit pattern. Numbers must be between 0 and 4 (duplicates OK).
3000
0 | 3 0 0 0  | ● ◌ ◌ ◌ 
1 |          |         
2 |          |         
3 |          |         
4 |          |         
5 |          |         
6 |          |         
7 |          |         
8 |          |         
9 |          |         

CODEBREAKER (PLAYER): Make a guess.
Choose a 4-digit pattern. Numbers must be between 0 and 4 (duplicates OK).
3400
0 | 3 0 0 0  | ● ◌ ◌ ◌ 
1 | 3 4 0 0  | ● ● ◌ ◌ 
2 |          |         
3 |          |         
4 |          |         
5 |          |         
6 |          |         
7 |          |         
8 |          |         
9 |          |         

CODEBREAKER (PLAYER): Make a guess.
Choose a 4-digit pattern. Numbers must be between 0 and 4 (duplicates OK).
3440
0 | 3 0 0 0  | ● ◌ ◌ ◌ 
1 | 3 4 0 0  | ● ● ◌ ◌ 
2 | 3 4 4 0  | ● ● ● ◌ 
3 |          |         
4 |          |         
5 |          |         
6 |          |         
7 |          |         
8 |          |         
9 |          |         

CODEBREAKER (PLAYER): Make a guess.
Choose a 4-digit pattern. Numbers must be between 0 and 4 (duplicates OK).
3441
0 | 3 0 0 0  | ● ◌ ◌ ◌ 
1 | 3 4 0 0  | ● ● ◌ ◌ 
2 | 3 4 4 0  | ● ● ● ◌ 
3 | 3 4 4 1  | ● ● ● ● 
4 |          |         
5 |          |         
6 |          |         
7 |          |         
8 |          |         
9 |          |         

You guessed the correct pattern!

CODEMAKER (CPU) pattern: 3 4 4 1 

------------- SWAP ROLES -------------- 

CODEMAKER (PLAYER): Select a pattern.
Choose a 4-digit pattern. Numbers must be between 0 and 4 (duplicates OK).
1234

CODEBREAKER (CPU): Make a guess.
0 | 1 1 2 2  | ● ◑ ◑ ◑ 
1 | 1 2 0 0  | ● ● ◌ ◌ 
2 | 1 2 1 1  | ● ● ◑ ◑ 
3 | 1 2 3 3  | ● ● ● ◑ 
4 | 1 2 3 4  | ● ● ● ● 
5 |          |         
6 |          |         
7 |          |         
8 |          |         
9 |          |         

Computer guessed the correct pattern!

CODEMAKER (PLAYER) pattern: 1 2 3 4 

============= END ROUND 0 ============= 
Player wins out of 1 games! Final score 4-3
```