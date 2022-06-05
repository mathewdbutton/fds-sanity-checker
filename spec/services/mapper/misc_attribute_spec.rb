require "rails_helper"

RSpec.describe Mapper::MiscAttribute do
  describe "#call" do
    it "assigns the fields correctly" do
      validation_run = create(:validation_run)
      tuple = NamelistExtractor::NamelistTuple.new(name: "Doesn't Matter", arguments: "SIMULATION_MODE='LES', NOISE=.TRUE., GVEC=1.2,0.,-9.81 /")

      surface = described_class.new(tuple, validation_run).call

      aggregate_failures do
        expect(surface).to be_an(Misc)
        expect(surface).to have_attributes(
          gvec_x: 1.2,
          gvec_y: 0.0,
          gvec_z: -9.81
        )
      end
    end
  end
end
