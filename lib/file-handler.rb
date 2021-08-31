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
    file_name = gets.chomp
    until file_name =~ /[a-z0-9.]/i
      print color_text('Enter a Valid File Name > ', :red)
      file_name = gets.chomp
    end
    file_name
  end

  def game_data
    filename = file_name
    until File.exist?("#{SAVE_DIR}/#{filename}")
      puts color_text('Enter a Valid File Name :)', :red)
      filename = file_name
    end
    YAML.safe_load(retrieve_file("#{SAVE_DIR}/#{filename}"), [Symbol])
  end

  def save_not_available?
    Dir.empty?(SAVE_DIR.to_s)
  end
end
