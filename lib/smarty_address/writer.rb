# frozen_string_literal: true

module SmartyAddress
  # Handle writing output
  class Writer
    class << self
      def print_address_candidate_result(address, candidate)
        puts "#{address} -> #{build_address_string(candidate)}"
      end

      private

      def build_address_string(candidate)
        return "Invalid Address" if candidate.nil?

        components = candidate.components
        [
          candidate.delivery_line_1,
          components.city_name,
          "#{components.zipcode}-#{components.plus4_code}"
        ].join(", ")
      end
    end
  end
end
