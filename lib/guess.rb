#!/usr/bin/env ruby
# frozen_string_literal: true

# Class Guess
class Guess
  attr_accessor :remaining_incorrect_guesses, :correct_guesses, :incorrect_guesses

  def validate(player_guess, secret_word)
    secret_word.include?(player_guess)
  end
end
