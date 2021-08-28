#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './file-handler'
require_relative './user'

# Class Game
class Game
  attr_reader :file_handler

  def initialize(user, file_handler, result)
    @user = user
    @file_handler = file_handler
    @result = result
    @total_guesses = 5
  end

  def new_game
    word = get_random_word
    update_game_state(word, [], [], 5)
  end

  def load_saved_game
    update_game_state('', '', '', 1)
  end

  private

  def update_game_state(secret_word, correct_guesses, incorrect_guesses, total_guesses)
    @secret_word = secret_word
    @correct_guesses = correct_guesses
    @incorrect_guesses = incorrect_guesses
    @total_guesses = total_guesses
  end

  def get_random_word
    dictionary = file_handler.retrieve_file('lib/dictionary.txt').split("\n")
    word = dictionary.sample
    word = dictionary.sample until word.length >= 5 && word.length <= 12
    word
  end
end

Game.new('user', FileHandler.new, 'result').new_game
