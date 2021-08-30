#!/usr/bin/env ruby
# frozen_string_literal: true

# Class Word
class Word
  attr_reader :file_handler
  attr_accessor :secret_word, :placeholder

  def initialize(file_handler)
    @file_handler = file_handler
  end

  def generate
    dictionary = file_handler.retrieve_file('lib/word_list/dictionary.txt').split("\n")
    word = dictionary.sample
    word = dictionary.sample until word.length >= 5 && word.length <= 12
    word.downcase
  end

  def update_placeholder(correct_guesses)
    return unless correct_guesses

    self.placeholder = secret_word.gsub(/[^"#{correct_guesses.join('')}"]/, ' _ ')
  end
end
