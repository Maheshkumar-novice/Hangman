#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file-handler'
require_relative 'user'
require_relative 'word'
require_relative 'guess'
require_relative 'modules/game_output'
require_relative 'modules/print-hangman'
require 'yaml'

# Class Game - Game Driver & Operations
class Game
  include GameOutput
  include PrintHangman

  SAVE_DIR = 'saved_games'

  attr_reader :user, :word, :guess, :file_handler
  attr_accessor :user_guess

  def initialize(user, word, guess, file_handler)
    @user = user
    @word = word
    @guess = guess
    @file_handler = file_handler
    @user_guess = nil
    @validation = nil
  end

  def intro
    print_game_intro
  end

  def start
    if user.make_choice == 'y'
      load_game
    else
      new_game
    end
    print_try_again_prompt
    start if gets.chomp.downcase == 'y'
  end

  private

  def new_game
    word.secret_word = word.generate
    word.placeholder = ' _ ' * word.secret_word.size
    create_game_state(5, [], [], word.secret_word, word.placeholder)
    play_the_game
  end

  def load_game
    return print_no_games_found if file_handler.save_not_available?

    hash = file_handler.game_data
    create_game_state(hash[:remaining_incorrect_guesses],
                      hash[:correct_guesses],
                      hash[:incorrect_guesses],
                      hash[:secret_word],
                      hash[:placeholder])
    play_the_game
  end

  def play_the_game
    print_game_state
    loop do
      process_the_game
      break print_thank_you if exit?
      break announce_result if game_end?
    end
  end

  def process_the_game
    create_user_guess
    return save_game if save?
    return if exit?

    if guess.already_guessed?(user_guess)
      print_already_guessed
    else
      validation = validate_user_guess
      update_game_state(validation)
    end
    print_game_state
  end

  def save_game
    filename = file_handler.file_name
    file_handler.save_file("#{SAVE_DIR}/#{filename}", YAML.dump(create_game_state_hash))
    print_game_saved
  end

  def update_game_state(validation)
    if validation
      update_correct_guesses
      update_placeholder
      return
    end

    update_incorrect_guesses
    decrease_remaining_incorrect_guesses
    print_hangman(guess.remaining_incorrect_guesses)
  end

  def create_user_guess
    self.user_guess = user.make_guess
    until user_guess =~ /^[a-z]{1}$/i
      break if user_guess =~ /^save$|^exit$/i

      print_user_guess_error
      self.user_guess = user.make_guess
    end
  end

  def create_game_state(remaining_incorrect_guesses, correct_guesses, incorrect_guesses, secret_word, placeholder)
    guess.remaining_incorrect_guesses = remaining_incorrect_guesses
    guess.correct_guesses = correct_guesses
    guess.incorrect_guesses = incorrect_guesses
    word.secret_word = secret_word
    word.placeholder = placeholder
  end

  def create_game_state_hash
    {
      remaining_incorrect_guesses: guess.remaining_incorrect_guesses,
      correct_guesses: guess.correct_guesses,
      incorrect_guesses: guess.incorrect_guesses,
      secret_word: word.secret_word,
      placeholder: word.placeholder
    }
  end

  def validate_user_guess
    guess.validate(user_guess, word.secret_word)
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

  def decrease_remaining_incorrect_guesses
    guess.remaining_incorrect_guesses -= 1
  end

  def game_end?
    return true if guess.remaining_incorrect_guesses.zero?
    return true if word.placeholder == word.secret_word

    false
  end

  def save?
    user_guess == 'save'
  end

  def exit?
    user_guess == 'exit'
  end
end
