require "rails_helper"

RSpec.describe LineUnbundler do
  # "&PRES VELOCITY_TOLERANCE=0.0001 /",
  #       "&SURF ID='SUCK', COLOR='RED' /"

  describe "#call" do
    it "converts file to array of strings" do
      text_blob = <<~FDS_MODEL
        &PRES VELOCITY_TOLERANCE=0.0001 / \n &SURF ID='SUCK',
              COLOR='RED' /
      FDS_MODEL

      lines = described_class.new(text_blob).call

      expect(lines.length).to eql(2)
    end

    it "removes extra whitespace" do
      text_blob = "       &SURF ID='SUCK',  COLOR='RED'/"

      lines = described_class.new(text_blob).call

      expect(lines[0]).to eql("&SURF ID='SUCK', COLOR='RED'/")
    end

    it "removes new lines" do
      text_blob = "&PRES VELOCITY_TOLERANCE=0.0001 \n/"

      lines = described_class.new(text_blob).call

      expect(lines[0]).to eql("&PRES VELOCITY_TOLERANCE=0.0001 /")
    end
  end
end
