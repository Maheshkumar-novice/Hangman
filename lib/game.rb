#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './file-handler'
require_relative './user'
require_relative './word'

# Class Game
class Game
  attr_reader :file_handler, :word

  def initialize(user, word, file_handler, result)
    @user = user
    @word = word
    @file_handler = file_handler
    @result = result
    @total_guesses = 5
  end

  def new_game
    word = self.word.generate
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
end

Game.new('user', Word.new(FileHandler.new), FileHandler.new, 'result').new_game
