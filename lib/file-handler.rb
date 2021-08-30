#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'color'

# Class FileHandler
class FileHandler
  include Color

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
    system('ls saved_games/')
    puts
  end

  def file_name
    list_files
    print color_text('Enter FileName > ', :magenta)
    gets.chomp
  end

  def game_data
    filename = file_name
    filename = file_name until File.exist?("saved_games/#{filename}")
    YAML.safe_load(retrieve_file("saved_games/#{filename}"), [Symbol])
  end
end

# puts FileHandler.new.get_file_name
# FileHandler.new.list_files
# Store.new.retrieve_file('lib/user.rb')
# Store.new.save_file('lib/a.txt', 'hello')
