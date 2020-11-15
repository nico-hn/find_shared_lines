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
end
