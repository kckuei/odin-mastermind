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
    print "\n\nEnter any key to continue.  "
    gets
  end
end

require 'set'
include Intro

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

def get_start_choice(input = '')
  loop do
    print "\nStart as code breaker (b) or maker (m) first?  "
    input = gets.chomp.downcase
    if input.include?('codebreaker') || input.include?('breaker') || input.include?('b')
      input = 'breaker'
      puts "\nUser has selected to begin as code#{input}."
      break
    elsif input.include?('codemaker') || input.include?('maker') || input.include?('m')
      input = 'maker'
      puts "\nUser has selected to begin as code#{input}."
      break
    else
      "\nInvalid input: #{input}"
    end
  end
  print "\nEnter any key to continue."
  gets
  input
end

def get_rounds(rounds = 3)
  loop do
    print "\nHow many rounds do you want to play (at least 1 round)?  "
    rounds = gets.chomp
    if contains_digits_only(rounds) && !rounds.empty? && !(rounds == '0')
      print "\nUser has selected to play #{rounds} rounds. "
      break
    else
      "\nInalid input: #{rounds}"
    end
  end
  print 'Enter any key to continue.'
  gets
  rounds.to_i
end

def solve_pattern_random(target_pattern, num_guesses, num_slots, num_choices)
  guesses = initialize_hash(num_guesses, num_slots)
  feedback = initialize_hash(num_guesses, num_slots)
  j = 0
  while j < num_guesses && !pattern_solved(feedback)
    guesses[j] = random_pattern(num_slots, num_choices)
    feedback[j] = give_feedback(target_pattern, guesses[j])
    j += 1
  end
  render_codebreaker_table(guesses, feedback, num_guesses, num_slots)
end

def solve_pattern_five(target_pattern, num_guesses, num_slots, num_choices)
  guesses = initialize_hash(num_guesses, num_slots)
  feedback = initialize_hash(num_guesses, num_slots)

  permutations = Array(Array(0..num_choices - 1).repeated_permutation(num_slots)).to_set

  guess = [1, 1, 2, 2]
  response = give_feedback(target_pattern, guess)

  guesses[0] = guess
  feedback[0] = response

  j = 1
  while j < num_guesses && response.count('●') != response.length
    permutations.each do |pattern|
      permutations.delete(pattern) if give_feedback(pattern, guess) != response
    end
    guess = permutations.first
    response = give_feedback(target_pattern, guess)
    guesses[j] = guess
    feedback[j] = response
    j += 1
  end
  render_codebreaker_table(guesses, feedback, num_guesses, num_slots)
  [guesses, feedback, j - 1]
end

def main
  # game intro
  fancy_intro

  # query game settings
  rounds = get_rounds

  ## initialize user/comp scores
  scores = { user: 0, comp: 0 }

  rounds.times do |k|
    puts "\n============ START ROUND #{k} ============ "

    rand_patt = random_pattern(NUM_SLOTS, NUM_CHOICES)
    puts "\nCODEMAKER (CPU) has selected a pattern: #{rand_patt.join(' ')} "
    ## puts "\nCODEMAKER has selected a pattern: * * * * "

    # initialize the guesses and feedback hashes
    guesses = initialize_hash(NUM_GUESSES, NUM_SLOTS)
    feedback = initialize_hash(NUM_GUESSES, NUM_SLOTS)

    # main event loop for one round : computer is maker, user is breaker
    j = 0
    while j < NUM_GUESSES && !pattern_solved(feedback)
      puts "\nCODEBREAKER (PLAYER): Make a guess."

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

    scores[:comp] += j - 1

    if pattern_solved(feedback)
      puts "\nYou guessed the correct pattern!"
    elsif j == NUM_GUESSES
      puts "\nYou used up all your guesses!"
    end
    puts "\nCODEMAKER (CPU) pattern: #{rand_patt.join(' ')} "

    puts "\n------------- SWAP ROLES -------------- "

    # main event loop for one round : user is maker, computer is breaker
    puts "\nCODEMAKER (PLAYER): Select a pattern."
    pattern = user_pattern(NUM_SLOTS, NUM_CHOICES)
    until validate_user_pattern(pattern, NUM_SLOTS)
      puts "\nInvalid input: #{pattern.join}"
      pattern = user_pattern(NUM_SLOTS, NUM_CHOICES)
    end
    puts "\nCODEBREAKER (CPU): Make a guess."
    results = solve_pattern_five(pattern, NUM_GUESSES, NUM_SLOTS, NUM_CHOICES)
    guesses = results[0]
    feedback = results[1]
    scores[:user] += results[2]

    if pattern_solved(feedback)
      puts "\nComputer guessed the correct pattern!"
    elsif j == NUM_GUESSES
      puts "\nComputer used up all your guesses!"
    end
    puts "\nCODEMAKER (PLAYER) pattern: #{pattern.join(' ')} "

    puts "\n============= END ROUND #{k} ============= "
  end
  if scores[:user] > scores[:comp]
    puts "\nPlayer wins out of #{rounds} games! Final score #{scores[:user]}-#{scores[:comp]}."
  elsif scores[:user] < scores[:comp]
    puts "\nComputer wins out of #{rounds} games! Final score #{scores[:comp]}-#{scores[:user]}."
  else
    puts "\nDraw out of #{rounds} games! Final score #{scores[:comp]}-#{scores[:user]}."
  end
end

main

# To do:
# 1. Modularize main loop
# 2. Then refactor/brainstorm into OOP paradigm then tidy and reformat
