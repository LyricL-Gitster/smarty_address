# frozen_string_literal: true

RSpec.describe SmartyAddress do
  it "has a version number" do
    expect(SmartyAddress::VERSION).not_to be nil
  end
end
