#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file-handler'
require_relative 'user'
require_relative 'word'
require_relative 'guess'
require_relative 'game_output'
require 'pry'

# Class Game
class Game
  include GameOutput

  attr_reader :user, :word, :guess, :file_handler
  attr_accessor :user_guess

  def initialize(user, word, guess, file_handler)
    @user = user
    @word = word
    @guess = guess
    @file_handler = file_handler
    @user_guess = nil
  end

  def new_game
    word.secret_word = word.generate
    word.placeholder = ' _ ' * word.secret_word.size
    update_game_state(10, [], [], word.secret_word, word.placeholder)
  end

  def load_game
    hash = file_handler.get_game_data
    update_game_state(hash[:remaining_guesses], hash[:correct_guesses],
                      hash[:incorrect_guesses], hash[:secret_word],
                      hash[:placeholder])
  end

  def play
    print_game_state
    loop do
      process_the_game
      break announce_result if game_end?
    end
  end

  private

  def save_game
    filename = file_handler.get_file_name
    file_handler.save_file("saved_games/#{filename}", YAML.dump(create_hash))
    print_game_saved
  end

  def save?
    user_guess == 'save'
  end

  def update_game_state(remaining_guesses, correct_guesses, incorrect_guesses, secret_word, placeholder)
    guess.remaining_guesses = remaining_guesses
    guess.correct_guesses = correct_guesses
    guess.incorrect_guesses = incorrect_guesses
    word.secret_word = secret_word
    word.placeholder = placeholder
  end

  def process_the_game
    create_guess
    return save_game if save?

    validation = validate_guess
    update_correct_guesses if validation
    update_placeholder if validation
    update_incorrect_guesses unless validation
    update_remaining_guesses
    print_game_state
  end

  def game_end?
    return true if guess.remaining_guesses.zero?
    return true if word.placeholder == word.secret_word

    false
  end

  def create_guess
    self.user_guess = user.make_guess

    until user_guess =~ /^[a-z]{1}$/i
      break if user_guess == 'save'

      self.user_guess = user.make_guess
    end
  end

  def validate_guess
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

  def update_remaining_guesses
    guess.remaining_guesses -= 1
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

g = Game.new(User.new('hi'), Word.new(FileHandler.new), Guess.new, FileHandler.new)
# g.new_game
g.load_game
g.play
