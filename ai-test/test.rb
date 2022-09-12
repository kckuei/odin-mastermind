require 'set'

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

num_guesses = 10
num_choices = 5
num_slots = 4
target_pattern = [0, 2, 0, 4]

# create set S of possible codes
set = Array(Array(0..num_choices - 1).repeated_permutation(num_slots)).to_set
p set
puts set.class

# Start with initial guess 1122
guess = [1, 1, 2, 2]

# Play the guess for a response
feedback = give_feedback(target_pattern, guess)
p "target pattern: #{target_pattern}"
p "target feedback: #{feedback}"

j = 0
while j < num_guesses && feedback.count('●') != feedback.length
  set.each do |pattern|
    if give_feedback(pattern, guess) != feedback
      # p "#{pattern} | #{give_feedback(target_pattern, pattern)}"
      set.delete(pattern)
    end
  end
  # remove from the set, any code that would not give the same response
  puts 'modified'
  puts set
  guess = set.first
  feedback = give_feedback(target_pattern, guess)

  j += 1
  puts j
end
