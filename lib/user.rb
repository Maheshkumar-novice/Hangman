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
    validate_input(gets.chomp)
  end

  private

  def validate_input(input)
    return input if input == 'save'

    until input =~ /^[a-z]{1}$/i
      print 'Enter Your Guess > '
      input = validate_input(gets.chomp)
    end

    input.downcase
  end
end

# puts User.new('hi').make_guess
