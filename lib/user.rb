#!/usr/bin/env ruby
# frozen_string_literal: true

# Class User
class User
  attr_reader :name

  def self.validate_name(name)
    puts name
  end

  def initialize(name)
    @name = name
  end

  def make_guess
    print 'Enter Your Guess > '
    validate_guess(gets.chomp[0])
  end

  private

  def validate_guess(guess)
    return guess if guess

    until guess
      print 'Enter Your Guess > '
      guess = validate_guess(gets.chomp[0])
    end

    guess
  end
end

# puts User.new('hi').make_guess
