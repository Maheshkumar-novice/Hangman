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
end

# Store.new.retrieve_file('lib/user.rb')
# Store.new.save_file('lib/a.txt', 'hello')
