#!/usr/bin/env ruby
# frozen_string_literal: true

# Class FileHandler
class FileHandler
  def retrieve_file(filename)
    File.read(filename)
  end

  def save_file(filename, contents)
    File.open(filename, 'w') do |file|
      file.puts contents
    end
  end

  def list_files
    puts "\nAll Saved Games:  "
    system('ls saved_games/')
    puts 
  end

  def get_file_name
    list_files
    print 'Enter FileName to Save/Load > '
    gets.chomp
  end

  def get_game_data
    filename = get_file_name
    filename = get_file_name until File.exist?("saved_games/#{filename}")
    YAML.load(retrieve_file("saved_games/#{filename}"))
  end
end

# puts FileHandler.new.get_file_name
# FileHandler.new.list_files
# Store.new.retrieve_file('lib/user.rb')
# Store.new.save_file('lib/a.txt', 'hello')
