require "rails_helper"

RSpec.describe SurfaceAttributeMapper do
  describe "#call" do
    it "assigns the fields correctly" do
      raw_attributes = "ID='SUCK', VOLUME_FLOW=0.01, COLOR='RED'"

      surface = described_class.new(raw_attributes).call

      aggregate_failures do
        expect(surface).to be_an(Surface)
        expect(surface).to have_attributes(char_id: "SUCK", volume_flow: 0.01)
      end
    end
  end
end
