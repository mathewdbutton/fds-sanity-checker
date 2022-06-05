require "rails_helper"

RSpec.describe NamelistFactory do
  describe "#call" do
    it "returns the correct Mapper class" do
      tuple = NamelistExtractor::NamelistTuple.new(name: "SURF", arguments: "something=something, something=else")

      mapper = described_class.call(tuple)

      aggregate_failures do
        expect(mapper).to be_an(Array)
        expect(mapper[0]).to be(Mapper::SurfaceAttribute)
        expect(mapper[1]).to be(tuple)
      end
    end

    context "when namelist is unknown"
    it "returns NoneMapper" do
      tuple = NamelistExtractor::NamelistTuple.new(name: "NOTFOUND", arguments: "something=something, something=else")

      mapper = described_class.call(tuple)

      aggregate_failures do
        expect(mapper).to be_an(Array)
        expect(mapper[0]).to be(NoneMapper)
        expect(mapper[1]).to be(tuple)
      end
    end
  end
end
