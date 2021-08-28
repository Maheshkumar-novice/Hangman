#!/usr/bin/env ruby
# frozen_string_literal: true

# Class Word
class Word
  attr_reader :file_handler

  def initialize(file_handler)
    @file_handler = file_handler
  end

  def generate
    dictionary = file_handler.retrieve_file('lib/dictionary.txt').split("\n")
    word = dictionary.sample
    word = dictionary.sample until word.length >= 5 && word.length <= 12
    word
  end
end
