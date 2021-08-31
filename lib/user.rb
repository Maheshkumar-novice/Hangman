#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'modules/color'

# Class User
class User
  include Color

  attr_accessor :name

  def initialize
    @user = 'Odinite'
  end

  def create_username
    print color_text('Enter User Name > ', :cyan)
    name = gets.chomp
    until name.strip.size >= 1
      print color_text("Enter a Valid UserName :) \n", :red)
      name = create_username
    end
    name
  end

  def make_guess
    print color_text('Enter Your Guess > ', :cyan)
    gets.chomp
  end

  def make_choice
    print color_text('Do you want load the saved game? ', :yellow)
    print color_text('(y/n) > ', :magenta)
    choice = gets.chomp
    choice = get_choice until choice =~ /^[y|n]{1}$/i
    choice
  end
end
