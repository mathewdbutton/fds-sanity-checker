require "fds_math"

RSpec.describe FDSMath do

  describe "#Pythagoras' Theorem" do
    it do
      expect(described_class.pythagoras_theorem(3,4)).to eq(5)
    end
  end
end
