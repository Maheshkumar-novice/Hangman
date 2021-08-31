#!/usr/bin/env ruby
# frozen_string_literal: true

# Module Hangman
module Hangman
  def print_hangman_1
    puts color_text("
      __
      ||------------
      ||         |
      ||         ◯
      ||
      ||
      ||
      ||
      ||
  ____||_____
  ", :yellow)
  end

  def print_hangman_2
    puts color_text("
      __
      ||------------
      ||         |
      ||         ◯
      ||       __|__
      ||
      ||
      ||
      ||
  ____||_____
  ", :yellow)
  end

  def print_hangman_3
    puts color_text("
      __
      ||------------
      ||         |
      ||         ◯
      ||       __|__
      ||         |
      ||
      ||
      ||
  ____||_____
  ", :yellow)
  end

  def print_hangman_4
    puts color_text("
      __
      ||------------
      ||         |
      ||         ◯
      ||       __|__
      ||         |
      ||        /
      ||
      ||
  ____||_____
  ", :yellow)
  end

  def print_hangman_dead
    puts color_text("
      __
      ||------------
      ||         |
      ||         ◯
      ||       __|__
      ||         |
      ||        / \\
      ||
      ||
  ____||_____
  ", :red)
  end

  def print_hangman_free
    puts color_text("
      __
      ||------------
      ||         |
      ||
      ||
      ||
      ||         ◯
      ||       __|__
      ||         |
  ____||________/ \\______
  ", :green)
  end

  def print_hangman(value)
    case value
    when 4
      print_hangman_1
    when 3
      print_hangman_2
    when 2
      print_hangman_3
    when 1
      print_hangman_4
    end
  end
end
