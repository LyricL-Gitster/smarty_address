# frozen_string_literal: true

require "smartystreets_ruby_sdk"

module SmartyAddress
  # Handle interactions with SmartyStreets SDK
  class ApiClient
    AUTH_ID = ENV.fetch("SMARTY_AUTH_ID", nil)
    AUTH_TOKEN = ENV.fetch("SMARTY_AUTH_TOKEN", nil)

    class << self
      def find_address_candidates(addresses)
        batch = build_batch addresses

        begin
          client.send_batch(batch)
        rescue SmartyStreets::SmartyError => e
          puts e
          return {}
        end

        build_batch_results_map batch
      end

      private

      def client
        @client ||= SmartyStreets::ClientBuilder.new(credentials).build_us_street_api_client
      end

      def credentials
        @credentials ||= SmartyStreets::StaticCredentials.new(AUTH_ID, AUTH_TOKEN)
      end

      def build_lookup(address) # rubocop:disable Metrics/MethodLength
        street, city, zipcode, * = address.split(",").map(&:strip)
        SmartyStreets::USStreet::Lookup.new(
          street,
          nil, # street2
          nil, # secondary
          city,
          nil, # state
          zipcode,
          nil, # lastline
          nil, # addressee
          nil, # urbanization
          nil, # match
          nil, # candidates
          address # input_id
        )
      end

      def build_batch_results_map(batch)
        batch.each_with_object({}) do |lookup, memo|
          memo[lookup.input_id] = lookup.result.first
        end
      end

      def build_batch(addresses)
        batch = SmartyStreets::Batch.new

        Array(addresses).each do |address|
          batch.add build_lookup(address)
        end

        batch
      end
    end
  end
end
