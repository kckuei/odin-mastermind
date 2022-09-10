# decide number of turns (e.g. 12)?
# decide codebreaker vs codemaker?
# decide how many games? (1 game means computer and player swap roles)
# decide if blanks or duplicates allowed?
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

# colors: R B G Y W -

# example
# codemaker: R B G Y
# codebreaker:
# 1| R G Y W | ● ◑ ◑ ◌
# 2| R G Y B | ● ◑ ◑ ◑
# 3| R B Y G | ● ● ◑ ◑
# 4| R B G Y | ● ● ● ●

puts '1 ... R G Y W | ● ◑ ◑ ◌'
