require "rails_helper"

RSpec.describe LineCleaner do
  # "&PRES VELOCITY_TOLERANCE=0.0001 /",
  #       "&SURF ID='SUCK', COLOR='RED' /"

  describe "#call" do
    it "removes extra whitespace" do
      text_blob = "       &SURF ID='SUCK',  COLOR='RED'/"

      line = described_class.new(text_blob).call

      expect(line).to eql("&SURF ID='SUCK', COLOR='RED'/")
    end

    it "removes new lines" do
      text_blob = "&PRES VELOCITY_TOLERANCE=0.0001 \n/"

      line = described_class.new(text_blob).call

      expect(line).to eql("&PRES VELOCITY_TOLERANCE=0.0001 /")
    end
  end
end
