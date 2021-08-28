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

  def initialize(user, word, guess, result, file_handler)
    @user = user
    @word = word
    @guess = guess
    @result = result
    @file_handler = file_handler
  end

  def new_game
    word.secret_word = word.generate
    update_game_state(word.secret_word, [], [], 5)
  end

  def play
    word.placeholder = ' _ ' * word.secret_word.size
    puts word.placeholder
    loop do
      user_guess = user.make_guess
      validation = guess.validate(user_guess, word.secret_word)
      word.update_placeholder(guess.correct_guesses) if validation

      guess.correct_guesses << user_guess if validation && !guess.correct_guesses.include?(user_guess)

      guess.incorrect_guesses << user_guess if !validation && !guess.incorrect_guesses.include?(user_guess)

      puts word.placeholder
      print "Correct Guesses: #{guess.correct_guesses}\n"
      print "Incorrect Guesses: #{guess.incorrect_guesses}\n"

      guess.total_guesses -= 1
      puts "Guesses Remaining #{guess.total_guesses}"
      break if guess.total_guesses.zero?
      break if word.placeholder == word.secret_word
    end
  end

  private

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
