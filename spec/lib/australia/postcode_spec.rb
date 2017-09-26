require "spec_helper"
require "australia/postcode"

RSpec.describe Australia::Postcode do
  describe ".find" do
    it "finds the postcode" do
      postcodes = Australia::Postcode.find(4000)
      expect(postcodes.size).to eq(3)

      postcode = postcodes.first
      expect(postcode.suburb).to eq("BRISBANE")
      expect(postcode.latitude).to eq(-27.46758)
      expect(postcode.longitude).to eq(153.027892)
    end
  end
end
