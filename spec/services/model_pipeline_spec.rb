require "rails_helper"

RSpec.describe ModelPipeline do
  describe "#call" do
    let(:test_file) { fixture_file_upload("test.fds") }

    it "produces the correct set of records" do
      records = described_class.call(test_file)

      expect(records).to contain_exactly(
        an_object_having_attributes(char_id: "SUCK", class: Surface, volume_flow: 0.01),
        an_object_having_attributes(char_id: "OPEN", class: Surface, volume_flow: -0.02),
        an_object_having_attributes(surface_id: "OPEN", class: Vent),
        an_object_having_attributes(surface_id: "SUCK", class: Vent),
        an_object_having_attributes(pbx: 0.20, quantity: "VELOCITY", vector: true, class: SliceFile),
        an_object_having_attributes(pby: 0.55, quantity: "VELOCITY", vector: true, class: SliceFile)
      )
    end

    context "larger file" do
      let(:test_file) { fixture_file_upload("larger_test.fds") }

      it "runs" do
        expect do
          records = described_class.call(test_file)
        end.not_to raise_error
      end
    end

    it "produces records that are all valid" do
      records = described_class.call(test_file)
      expect(records).to all(be_valid)
    end
  end
end
