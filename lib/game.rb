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
    update_game_state(word.secret_word, [], [], 15)
  end

  def play
    word.update_placeholder(guess.correct_guesses)
    print_result
    print_remaining_guesses
    loop do
      process
      check_end
    end
  end

  private

  def process
    create_guess

    validation = validate_guess
    update_correct_guesses if validation
    update_placeholder if validation
    update_incorrect_guesses unless validation

    print_result
    update_total_guesses
    print_remaining_guesses
  end

  def check_end
    break if guess.total_guesses.zero?
    break if word.placeholder == word.secret_word
  end

  def print_remaining_guesses
    puts "Guesses Remaining #{guess.total_guesses}"
  end

  def print_result
    puts word.placeholder
    print "Correct Guesses: #{guess.correct_guesses}\n"
    print "Incorrect Guesses: #{guess.incorrect_guesses}\n"
  end

  def create_guess
    self.user_guess = user.make_guess
  end

  def validate_guess
    guess.validate(user_guess, word.secret_word)
  end

  def update_total_guesses
    guess.total_guesses -= 1
  end

  def update_placeholder
    word.update_placeholder(guess.correct_guesses)
  end

  def update_correct_guesses
    guess.correct_guesses << user_guess unless guess.correct_guesses.include?(user_guess)
  end

  def update_incorrect_guesses
    guess.incorrect_guesses << user_guess unless guess.incorrect_guesses.include?(user_guess)
  end

  def update_game_state(secret_word, correct_guesses, incorrect_guesses, total_guesses)
    word.secret_word = secret_word
    guess.correct_guesses = correct_guesses
    guess.incorrect_guesses = incorrect_guesses
    guess.total_guesses = total_guesses
  end
end

g = Game.new(User.new('hi'), Word.new(FileHandler.new), Guess.new, 'result', FileHandler.new)
g.new_game
g.play
