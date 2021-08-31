#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './lib/game'

user = User.new
user.name = user.create_username
game = Game.new(user, Word.new(FileHandler.new), Guess.new, FileHandler.new)
game.intro
game.start
