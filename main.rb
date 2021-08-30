#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './lib/game'

game = Game.new(User.new('hi'), Word.new(FileHandler.new), Guess.new, FileHandler.new)
game.new_game
# g.load_game
game.play
