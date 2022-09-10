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

# puts '1 ... 0 2 3 4 | ● ◑ ◑ ◌'

NUM_SLOTS = 4
NUM_CHOICES = 5

def user_pattern(num_slots, num_choices, _pattern = [])
  puts "Choose a #{num_slots}-digit pattern. Numbers must be between 0 and #{num_choices - 1} (duplicates OK)."
  gets.chomp.split('')
end

def contains_digits_only(string)
  string = string.join if string.instance_of?(Array)
  string.scan(/\D/).empty?
end

def validate_user_pattern(pattern, num_slots)
  return false if pattern.length != num_slots
  return false unless contains_digits_only(pattern)
  return false if pattern.map(&:to_i).max > NUM_CHOICES - 1
  return false if pattern.map(&:to_i).min.negative?

  true
end

def random_pattern(num_slots, num_choices, pattern = [])
  num_slots.times { |_i| pattern << Random.rand(num_choices) }
  pattern
end

rand_patt = random_pattern(NUM_SLOTS, NUM_CHOICES)

user_patt = user_pattern(NUM_SLOTS, NUM_CHOICES)

puts validate_user_pattern(user_patt, NUM_SLOTS)
