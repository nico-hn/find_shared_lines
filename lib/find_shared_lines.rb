# frozen_string_literal: true

require 'set'
require 'find_shared_lines/version'

module FindSharedLines
  class Error < StandardError; end

  def self.read_lines_from(file)
    File.open(file).readlines.map(&:chomp)
  end

  def self.read_file_into_set(file)
    Set.new(read_lines_from(file))
  end

  def self.reduce(files)
    first_file, *rest = files
    first_set = read_file_into_set(first_file)
    rest.reduce(first_set) { |acc, file| yield acc, read_file_into_set(file) }
  end

  def self.exclude_shared_lines(files)
    reduce(files) { |first_file, file| first_file - file }
  end

  def self.shared_lines(files)
    reduce(files) { |first_file, file| first_file & file }
  end

  def self.join(files)
    reduce(files) { |first_file, file| first_file | file }
  end
end
