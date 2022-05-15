require "rails_helper"

RSpec.describe NamelistExtractor do
  describe "#call" do
    it "returns Namelist Tuple with the correct fields" do
      text_blob = "&PRES VELOCITY_TOLERANCE=0.0001, MAX_PRESSURE_ITERATIONS=100, SUSPEND_PRESSURE_ITERATIONS=F"

      namelist_tuple = described_class.new(text_blob).call

      expect(namelist_tuple).to have_attributes(
        name: "PRES",
        arguments: "VELOCITY_TOLERANCE=0.0001, MAX_PRESSURE_ITERATIONS=100, SUSPEND_PRESSURE_ITERATIONS=F"
      )
    end

    it "removes the forward slash off the end of the arguments" do
      text_blob = "&PRES VELOCITY_TOLERANCE=0.0001 /"

      namelist_tuple = described_class.new(text_blob).call

      expect(namelist_tuple).to have_attributes(
        name: "PRES",
        arguments: "VELOCITY_TOLERANCE=0.0001"
      )
    end
  end
end
