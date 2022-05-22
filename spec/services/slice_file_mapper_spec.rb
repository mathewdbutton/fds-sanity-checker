require "rails_helper"

RSpec.describe SliceFileAttributeMapper do
  describe "#call" do
    it "picks up the correct fields" do
      validation_run = create(:validation_run)
      tuple = NamelistExtractor::NamelistTuple.new(name: "Doesn't Matter", arguments: "PBX=0.20, QUANTITY='VELOCITY', VECTOR=.TRUE.")

      mapped_class = described_class.new(tuple, validation_run).call

      aggregate_failures do
        expect(mapped_class).to be_an(SliceFile)
        expect(mapped_class).to have_attributes(pbx: 0.20, quantity: "VELOCITY", vector: true)
      end
    end
  end
end
