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

def render_codebreaker_table(guesses, feedback, num_guesses, num_slots)
  num_guesses.times do |i|
    guess_patt = guesses[i].join(' ')
    feedb_patt = feedback[i].join(' ')
    puts "#{i} | #{format(guess_patt, num_slots)} |" << " #{format(feedb_patt, num_slots)}"
  end
end

def pattern_solved(feedback)
  feedback.each do |_key, value|
    return true if value.count('●') == value.length
  end
  false
end

rand_patt = random_pattern(NUM_SLOTS, NUM_CHOICES)
puts "Codebreaker pattern: #{rand_patt.join(' ')} "

# initialize the gussess hash
guesses = initialize_hash(NUM_GUESSES, NUM_SLOTS)
feedback = initialize_hash(NUM_GUESSES, NUM_SLOTS)

j = 0
while j < NUM_GUESSES && !pattern_solved(feedback)
  puts "\nCODEBREAKER: Make a guess."

  pattern = user_pattern(NUM_SLOTS, NUM_CHOICES)
  until validate_user_pattern(pattern, NUM_SLOTS)
    puts "\nInvalid input: #{pattern.join}"
    pattern = user_pattern(NUM_SLOTS, NUM_CHOICES)
  end
  guesses[j] = pattern
  feedback[j] = give_feedback(rand_patt, guesses[j])

  render_codebreaker_table(guesses, feedback, NUM_GUESSES, NUM_SLOTS)
  j += 1
end

# Need validate code input=

# Next, implement one full game loop with user as codebreaker
# Then refactor/brainstorm into OOP paradigm
# Then implement computer guessing algorithm
# Then tidy / format

# include Intro
# fancy_intro

# user_patt = user_pattern(NUM_SLOTS, NUM_CHOICES)
# puts validate_user_pattern(user_patt, NUM_SLOTS)
