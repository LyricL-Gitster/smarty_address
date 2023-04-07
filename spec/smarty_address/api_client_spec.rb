# frozen_string_literal: true

RSpec.describe SmartyAddress::ApiClient do
  context "find_address_candidates" do
    it "maps a candidate result to each address when present" do
      mock_client = create_mock_smarty_client
      stub_api_results mock_client

      addresses = [
        "143 e Maine Street, Columbus, 43215",
        "1 Empora St, Title, 11111"
      ]

      result = SmartyAddress::ApiClient.find_address_candidates(addresses)

      expect(result.count).to eq(2)
      expect(result.keys).to eq(addresses)
      expect(result.values.map(&:class)).to eq([
                                                 SmartyStreets::USStreet::Candidate,
                                                 SmartyStreets::USStreet::Candidate
                                               ])
    end

    it "maps nil to each address when no candidates" do
      mock_client = create_mock_smarty_client
      stub_api_results mock_client, is_results: false

      addresses = [
        "143 e Maine Street, Columbus, 43215",
        "1 Empora St, Title, 11111"
      ]

      result = SmartyAddress::ApiClient.find_address_candidates(addresses)

      expect(result.count).to eq(2)
      expect(result.keys).to eq(addresses)
      expect(result.values.map(&:class)).to eq([
                                                 NilClass,
                                                 NilClass
                                               ])
    end

    it "handles API errors gracefully" do
      mock_client = create_mock_smarty_client
      allow(mock_client).to receive(:send_batch).and_raise(SmartyStreets::SmartyError)

      expect(SmartyAddress::ApiClient.find_address_candidates([])).to eq({})
    end
  end

  def create_mock_smarty_client
    mock_client = double("SmartyStreets::ClientBuilder")
    allow(SmartyAddress::ApiClient).to receive(:client).and_return(mock_client)

    mock_client
  end

  def stub_api_results(client, is_results: true) # rubocop:disable Metrics/MethodLength
    allow(client).to receive(:send_batch) do |batch|
      batch.each do |lookup|
        lookup.result = if is_results
                          candidate_attrs = {
                            "input_id" => lookup.input_id,
                            "delivery_line_1" => "delivery_line_1_#{lookup.input_id}",
                            "components" => {
                              "city_name" => "city_name_#{lookup.input_id}",
                              "zipcode" => "zipcode_#{lookup.input_id}",
                              "plus4_code" => "plus4_code_#{lookup.input_id}"
                            }
                          }
                          [
                            SmartyStreets::USStreet::Candidate.new(candidate_attrs)
                          ]
                        else
                          []
                        end
      end

      true
    end
  end
end
