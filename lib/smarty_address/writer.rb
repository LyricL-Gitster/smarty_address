# frozen_string_literal: true

require "smartystreets_ruby_sdk"

module SmartyAddress
  # Handle writing output
  class Writer
    class << self
      def print_address_candidate_result(address, candidate)
        print "#{address} -> "

        if candidate.nil?
          puts "Invalid Address"
          return
        end

        puts address_from_candidate(candidate)
      end

      private

      def address_from_candidate(candidate)
        components = candidate.components

        [
          candidate.delivery_line_1,
          candidate.city,
          "#{components.zipcode}-#{components.plus4_code}"
        ].join(", ")
      end
    end
  end
end
