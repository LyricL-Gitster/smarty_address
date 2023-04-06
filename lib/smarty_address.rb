# frozen_string_literal: true

require "dotenv"
Dotenv.load

require_relative "smarty_address/api_client"
require_relative "smarty_address/version"

# Main module
module SmartyAddress
  class Error < StandardError; end
  # Your code goes here...

  class << self
    def parse_csv(filename)
      _headers, *data = CSV.read(filename)

      data
    end

    def print_formatted_addresses(raw_addresses)
      address_candidate_map = ApiClient.find_candidates_for_addresses raw_addresses
      address_candidate_map.each do |address, candidate|
        Writer.print_address_candidate_result(address, candidate)
      end
    end
  end
end
