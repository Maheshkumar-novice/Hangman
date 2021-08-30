#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'modules/color'

# Class User
class User
  include Color

  attr_reader :name

  def self.validate_name(name)
    puts name
  end

  def initialize(name)
    @name = name
  end

  def make_guess
    print color_text('Enter Your Guess > ', :cyan)
    gets.chomp
  end
end
