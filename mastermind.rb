# decide number of turns (e.g. 12)?
# decide codebreaker vs codemaker?
# decide how many games? (1 game means computer and player swap roles)
# decide if blanks or duplicates allowed?
#   ignore blanks, but allow duplicates
# codemaker picks pattern (e.g. 4 colors and their position)

# for number of games
#   while less than specified number of turns (12)...
#     codebreaker picks a pattern
#     codemaker provides feedback
#            ● - correct position and color
#            ◑ - correct color, wrong position
#            ◌ - incorrect color and position
#   tally points - codemaker gets 1 point for each guess/row utilized by codebreaker
#   switch roles
# user with most points is declared winner

# colors: 0 1 2 3 4 -

# example
# codemaker: 0 1 2 3
# codebreaker:
# 1| 0 2 3 4 | ● ◑ ◑ ◌
# 2| 0 2 3 1 | ● ◑ ◑ ◑
# 3| 0 1 3 2 | ● ● ◑ ◑
# 4| 0 1 2 3 | ● ● ● ●

# Secret number: 4034
# Every round there are A bagels and 1 picos.

# [12 digit: 0] 1. 0000  1A01  (so there's one 0)
# [12 digit: 1] 2. 0111  0A11  (so there's no 1's, and the 0 is in the wrong place)
# [12 digit: 2] 3. 2022  1A01  (so there's no 2's either, but we know where the 0 is now)
# [12 digit: 3] 4. 3033  2A01  (so there's one 3, because A+1 increased by 1)
# [12 digit: 4] 5. 3044  2A21  (you now have all the numbers, just not in the right order)
# [12 digit: -] 6. 4043  2A21  (the switch didn't work, try another one)
# [12 digit: -] 7. 4034  4A01  (you win!)

puts '1 ... 0 2 3 4 | ● ◑ ◑ ◌'
