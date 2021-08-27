#!/usr/bin/env ruby
# frozen_string_literal: true

# Class Game
class Game
  def initialize(user, store, result)
    @user = user
    @store = store
    @result = result
    @total_guesses = 5
  end

  def new_game
    update_game_state('', '', '', 5)
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
