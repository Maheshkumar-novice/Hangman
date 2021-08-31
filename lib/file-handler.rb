#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'modules/color'
require 'yaml'

# Class FileHandler - Game Related File Operations
class FileHandler
  include Color

  SAVE_DIR = 'saved_games'

  def retrieve_file(filename)
    File.read(filename)
  end

  def save_file(filename, contents)
    File.open(filename, 'w') do |file|
      file.puts contents
    end
  end

  def list_files
    puts color_text("\nAll Saved Games:  ", :green)
    system("ls #{SAVE_DIR}")
    puts color_text('No Saved Games Found! :(', :red) if save_not_available?
    puts
  end

  def file_name
    list_files
    print color_text('Enter FileName > ', :magenta)
    gets.chomp
  end

  def game_data
    filename = file_name
    filename = file_name until File.exist?("#{SAVE_DIR}/#{filename}")
    YAML.safe_load(retrieve_file("#{SAVE_DIR}/#{filename}"), [Symbol])
  end

  def save_not_available?
    Dir.empty?(SAVE_DIR.to_s)
  end
end
