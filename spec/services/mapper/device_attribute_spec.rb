require "rails_helper"

RSpec.describe Mapper::DeviceAttribute do
  describe "#call" do
    it "assigns the fields correctly" do
      validation_run = create(:validation_run)
      tuple = NamelistExtractor::NamelistTuple.new(name: "Doesn't Matter", arguments: "ID='f150', XB=0.45,2.10,0.0,0.0,1.8,1.8, ORIENTATION=-1,0,0, POINTS=34, QUANTITY='RADIATIVE HEAT FLUX', HIDE_COORDINATES=.TRUE.")

      surface = described_class.new(tuple, validation_run).call

      aggregate_failures do
        expect(surface).to be_an(Device)
        expect(surface).to have_attributes(
          orientation: "-1,0,0",
          quantity: "RADIATIVE HEAT FLUX",
          char_id: "f150"
        )
      end
    end
  end
end
