require "rails_helper"

RSpec.describe LineUnbundler do
  describe "#call" do
    let(:text_blob) do
      <<~FDS_MODEL
        &PRES VELOCITY_TOLERANCE=0.0001 / \n &SURF ID='SUCK',
              COLOR='RED' /
      FDS_MODEL
    end
    it "converts file to array of strings" do
      lines = described_class.new(text_blob).call

      expect(lines).to include(
        "&PRES VELOCITY_TOLERANCE=0.0001 /",
        "&SURF ID='SUCK',      COLOR='RED' /"
      )
    end

    it "removes all new lines" do
      lines = described_class.new(text_blob).call

      expect(lines[0]).not_to include("\n")
    end
  end
end
