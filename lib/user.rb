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
    gets.chomp
  end
end

# puts User.new('hi').make_guess
