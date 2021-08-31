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
      puts color_text('Enter a Valid UserName :)', :red)
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
    until choice =~ /^[y|n]{1}$/i
      puts color_text('Enter a Valid Option (y/n) :)', :red)
      choice = get_choice
    end
    choice
  end
end
