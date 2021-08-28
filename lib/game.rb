#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './file-handler'
require_relative './user'
require_relative './word'
require_relative './guess'
require 'pry'

# Class Game
class Game
  attr_reader :user, :word, :guess, :result, :file_handler
  attr_accessor :user_guess

  def initialize(user, word, guess, result, file_handler)
    @user = user
    @word = word
    @guess = guess
    @result = result
    @file_handler = file_handler
    @user_guess = nil
  end

  def new_game
    word.secret_word = word.generate
    update_game_state(word.secret_word, [], [], 2)
  end

  def save_game
    puts '================'
    hash = create_hash
    file_handler.save_file('save.yaml', YAML.dump(hash))
    # puts YAML.load(YAML.dump(hash))
    puts '================'
  end

  def play
    word.update_placeholder(guess.correct_guesses)
    print_result
    print_remaining_guesses
    loop do
      process
      break if game_end?
    end
  end

  private

  def update_game_state(secret_word, correct_guesses, incorrect_guesses, remaining_guesses)
    word.secret_word = secret_word
    guess.correct_guesses = correct_guesses
    guess.incorrect_guesses = incorrect_guesses
    guess.remaining_guesses = remaining_guesses
  end

  def process
    create_guess

    validation = validate_guess
    update_correct_guesses if validation
    update_placeholder if validation
    update_incorrect_guesses unless validation

    print_result
    update_remaining_guesses
    print_remaining_guesses
  end

  def game_end?
    return true if guess.remaining_guesses.zero?
    return true if word.placeholder == word.secret_word

    false
  end

  def create_guess
    self.user_guess = user.make_guess
  end

  def validate_guess
    save_game if user_guess == 'y'
    guess.validate(user_guess, word.secret_word)
  end

  def update_correct_guesses
    guess.correct_guesses << user_guess unless guess.correct_guesses.include?(user_guess)
  end

  def update_placeholder
    word.update_placeholder(guess.correct_guesses)
  end

  def update_incorrect_guesses
    guess.incorrect_guesses << user_guess unless guess.incorrect_guesses.include?(user_guess)
  end

  def print_result
    puts word.placeholder
    print "Correct Guesses: #{guess.correct_guesses.join(' ')}\n"
    print "Incorrect Guesses: #{guess.incorrect_guesses.join(' ')}\n"
  end

  def update_remaining_guesses
    guess.remaining_guesses -= 1
  end

  def print_remaining_guesses
    puts "Guesses Remaining #{guess.remaining_guesses}"
  end

  def create_hash
    {
      remaining_guesses: guess.remaining_guesses,
      correct_guesses: guess.correct_guesses,
      incorrect_guesses: guess.incorrect_guesses,
      secret_word: word.secret_word,
      placeholder: word.placeholder
    }
  end
end

g = Game.new(User.new('hi'), Word.new(FileHandler.new), Guess.new, 'result', FileHandler.new)
g.new_game
g.play
