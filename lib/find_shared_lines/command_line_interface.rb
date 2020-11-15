# frozen_string_literal: true

require 'optparse'
require 'find_shared_lines'

module FindSharedLines
  module CommandLineInterface
    module OPTION
      EXCLUDE = :exclude_shared_lines
      JOIN = :join
      SHARED = :shared_lines
    end

    def self.parse_options
      banner = "USAGE: #{File.basename($PROGRAM_NAME)} [OPTION] [Files]..."
      option = OPTION::SHARED

      OptionParser.new(banner) do |opt|
        opt.on('-e', '--exclude-shared-lines',
               'Exclude lines commonly included in given files') do
          option = OPTION::EXCLUDE
        end

        opt.on('-s', '--shared-lines',
               'Collect lines shared in given files') do
          option = OPTION::SHARED
        end

        opt.on('-j', '--join-lines',
               'Collect all lines in given files') do
          option = OPTION::JOIN
        end

        opt.parse!
      end

      option
    end

    def self.result(option)
      case option
      when OPTION::SHARED
        FindSharedLines.shared_lines(ARGV)
      when OPTION::EXCLUDE
        FindSharedLines.exclude_shared_lines(ARGV)
      when OPTION::JOIN
        FindSharedLines.join(ARGV)
      end
    end

    def self.execute
      option = parse_options

      if ARGV.empty?
        warn 'At least 1 file should be given.'
      else
        $stdout.puts result(option).sort
      end
    end
  end
end
