# frozen_string_literal: true

require "dotenv"
Dotenv.load

require "csv"
require "optparse"
require_relative "smarty_address/api_client"
require_relative "smarty_address/version"
require_relative "smarty_address/writer"

# Main module
module SmartyAddress
  class Error < StandardError; end
  # Your code goes here...

  class << self
    def execute
      options = parsed_options
      filename = ARGV[0]

      unless options[:version].nil?
        puts "Smarty Address v#{VERSION}"
        return
      end

      _headers, *data = filename.nil? ? build_data_from_stdin : File.read(filename).split("\n")
      find_and_print_formatted_addresses(data)
    end

    def find_and_print_formatted_addresses(raw_addresses)
      address_candidate_map = ApiClient.find_address_candidates raw_addresses
      address_candidate_map.each do |address, candidate|
        Writer.print_address_candidate_result(address, candidate)
      end
    end

    private

    # either read piped data or next input
    def build_data_from_stdin
      puts "Enter headers and addresses in CSV format"
      data = []
      text = gets

      while !text.nil? && text != "\n"
        data += [text.strip]
        text = gets
      end

      print "\r\e[A\e[J" # clear previous line of text from STDOUT

      data
    end

    def parsed_options
      @parsed_options ||= begin
        temp_options = {}
        OptionParser.new do |opts|
          opts.banner = "Usage: smarty_address [options|filepath]"

          opts.on("-v", "--version", "See current version") do |v|
            temp_options[:version] = v
          end
        end.parse!

        temp_options
      end
    end
  end
end
