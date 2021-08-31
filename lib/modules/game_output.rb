#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'color'

# Module GameOutput
module GameOutput
  include Color

  def print_game_state
    puts <<~GAME

      #{color_text('Secret Holder: ', :yellow)}#{word.placeholder}
      #{color_text('Correct Guesses: ', :green)}#{guess.correct_guesses.join(' ')}
      #{color_text('Incorrect Guesses: ', :red)}#{guess.incorrect_guesses.join(' ')}
      #{color_text('Incorrect Guesses Remaining: ', :magenta)}#{guess.remaining_incorrect_guesses}

    GAME
  end

  def print_game_saved
    puts 'Game Saved!'
  end

  def announce_user_win
    puts <<~WIN
      #{color_text('User: ', :cyan)}#{color_text("#{user.name} ", :magenta)}#{color_text('Won!', :green)}
    WIN
  end

  def announce_user_lost
    puts <<~LOST
      #{color_text('User: ', :cyan)}#{color_text("#{user.name} ", :magenta)}#{color_text('Lost!', :red)}
    LOST
  end

  def announce_result
    print color_text('Secret Word: ', :cyan)
    print color_text("#{word.secret_word}\n", :magenta)
    if word.placeholder == word.secret_word
      announce_user_win
    else
      announce_user_lost
    end
  end

  def print_no_games_found
    puts color_text('No Saved Games Found!', :red)
  end

  def print_try_again_prompt
    print color_text('Try Again? ', :cyan)
    print color_text('(y/n) > ', :yellow)
  end

  def print_already_guessed
    print color_text("You Already Guessed This Letter! :)\n", :red)
  end
end
