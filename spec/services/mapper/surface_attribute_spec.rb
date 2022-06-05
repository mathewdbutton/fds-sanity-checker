require "rails_helper"

RSpec.describe Mapper::SurfaceAttribute do
  describe "#call" do
    it "assigns the fields correctly" do
      validation_run = create(:validation_run)
      tuple = NamelistExtractor::NamelistTuple.new(name: "Doesn't Matter", arguments: "ID='SUCK', VOLUME_FLOW = 0.01, COLOR='RED'")

      surface = described_class.new(tuple, validation_run).call

      aggregate_failures do
        expect(surface).to be_an(Surface)
        expect(surface).to have_attributes(char_id: "SUCK", volume_flow: 0.01)
      end
    end
  end
end
