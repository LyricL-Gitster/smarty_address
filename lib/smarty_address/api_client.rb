# frozen_string_literal: true

require "smartystreets_ruby_sdk"

module SmartyAddress
  # Handle interactions with SmartyStreets SDK
  class ApiClient
    AUTH_ID = ENV.fetch("SMARTY_AUTH_ID", nil)
    AUTH_TOKEN = ENV.fetch("SMARTY_AUTH_TOKEN", nil)

    class << self
      def find_candidates_for_addresses(raw_addresses)
        addresses = Array(raw_addresses)
        batch = SmartyStreets::Batch.new

        addresses.each do |addr|
          batch.add address_lookup(addr)
        end

        begin
          client.send_batch(batch)
        rescue SmartyStreets::SmartyError => e
          puts e
          return
        end

        batch.each_with_object({}) do |_results, _memo|
          candidate = lookup.result.first
          memo[lookup.input_id] = if candidate.nil?
                                    "Invalid Address"
                                  else
                                    components = candidate.components
                                    [
                                      candidate.delivery_line_1,
                                      candidate.city,
                                      "#{components.zipcode}-#{components.plus4_code}"
                                    ].join(", ")
                                  end
        end
      end

      private

      def client
        @client ||= SmartyStreets::ClientBuilder.new(credentials).build_us_street_api_client
      end

      def credentials
        @credentials ||= SmartyStreets::StaticCredentials.new(AUTH_ID, AUTH_TOKEN)
      end

      def address_lookup(address) # rubocop:disable Metrics/MethodLength
        street, city, zipcode, * = address.split ","

        SmartyStreets::USStreet::Lookup.new(
          street.strip, # street1
          nil, # street2
          nil, # secondary
          city.strip,
          nil, # state
          zipcode.strip,
          nil, # lastline
          nil, # addressee
          nil, # urbanization
          nil, # match
          nil, # candidates
          address # input_id
        )
      end
    end
  end
end
