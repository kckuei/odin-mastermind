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

module Intro
  ODIN = "         AN
░█▀█░█▀▄░▀█▀░█▀█░░░█▀█░█▀▄░█▀█░█▀▄░█░█░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀
░█░█░█░█░░█░░█░█░░░█▀▀░█▀▄░█░█░█░█░█░█░█░░░░█░░░█░░█░█░█░█░▀▀█
░▀▀▀░▀▀░░▀▀▀░▀░▀░░░▀░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀
                                    PRESENTS
\n\n".freeze

  LOGO = "
███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗██████╗
████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗
██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║██║  ██║
██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██║  ██║
██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██████╔╝
╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═════╝
                                                   CODE-BREAKERS VERSUS CODE-MAKERS
\n\n".freeze

  def cls
    system('cls')
  end

  def fancy_intro
    cls
    puts ODIN
    sleep(1.2)
    cls
    puts LOGO
    puts "\n\nEnter any key to continue."
    gets
  end
end

NUM_SLOTS = 4
NUM_CHOICES = 5
NUM_GUESSES = 10

# can be used for codemaker or for codebreaker guesses
def user_pattern(num_slots, num_choices, _pattern = [])
  puts "Choose a #{num_slots}-digit pattern. Numbers must be between 0 and #{num_choices - 1} (duplicates OK)."
  gets.chomp.split('')
end

def contains_digits_only(string)
  string = string.join if string.instance_of?(Array)
  string.scan(/\D/).empty?
end

# can be used to validate codemaker input and codebreaker guesses
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

# can be used for storing feedback and hashes
def initialize_hash(num_guesses, num_slots)
  guesses = {}
  (0..num_guesses - 1).each { |i| guesses[i] = Array.new(num_slots, nil) }
  guesses
end

def format(pattern, num_slots)
  pattern.to_s.ljust(num_slots * 2)
end

def give_feedback(codemaker_pattern, codebreaker_pattern)
  codebreaker_pattern = codebreaker_pattern.map(&:to_i)
  codemaker_pattern = codemaker_pattern.map(&:to_i)
  feedback = []
  codebreaker_pattern.each_with_index do |elem, i|
    feedback << if codemaker_pattern[i] == elem
                  '●'
                elsif codemaker_pattern.include?(elem)
                  '◑'
                else
                  '◌'
                end
  end
  feedback
end

def show_codebreaker_table; end

rand_patt = random_pattern(NUM_SLOTS, NUM_CHOICES)
puts "Codebreaker pattern: #{rand_patt.join(' ')} "

# user_patt = user_pattern(NUM_SLOTS, NUM_CHOICES)
# puts validate_user_pattern(user_patt, NUM_SLOTS)

# initialize the gussess hash
guesses = initialize_hash(NUM_GUESSES, NUM_SLOTS)
feedback = initialize_hash(NUM_GUESSES, NUM_SLOTS)

# make a guess and add it to the guess/feedback hashes
puts 'Make a guess'
guesses[0] = user_pattern(NUM_SLOTS, NUM_CHOICES)
feedback[0] = give_feedback(rand_patt, guesses[0])

# function to make suggestions based on guess, i.e. to produce this string ' ● ◑ ◑ ◌'
# which will get appended to the summary table

# preview the table
NUM_GUESSES.times do |i|
  guess_patt = guesses[i].join(' ')
  feedb_patt = feedback[i].join(' ')
  puts "#{i} | #{format(guess_patt, NUM_SLOTS)} |" << " #{format(feedb_patt, NUM_SLOTS)}"
end

# Next, implement one full game loop with user as codebreaker
# Then refactor/brainstorm into OOP paradigm
# Then implement computer guessing algorithm
# Then tidy / format

# include Intro
# fancy_intro
