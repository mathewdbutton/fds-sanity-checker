require "rails_helper"

RSpec.describe RegexLibrary do
  describe "REAL_NUMBER" do
    it "picks up positive numbers" do
      matched_value = "PARAM=01.02".match(described_class::REAL_NUMBER)[:value]

      expect(matched_value).to eql("01.02")
    end

    it "picks up negative numbers" do
      matched_value = "PARAM=-01.02".match(described_class::REAL_NUMBER)[:value]

      expect(matched_value).to eql("-01.02")
    end
  end

  describe "WORD" do
    it "picks up words" do
      matched_value = "PARAM='testing-testing', someother stuff".match(described_class::WORD)[:value]

      expect(matched_value).to eql("testing-testing")
    end
  end

  describe "LOGICAL" do
    it "picks up true" do
      matched_value = "VECTOR=.TRUE.', someother stuff".match(described_class::LOGICAL)[:value]

      expect(matched_value).to eql("TRUE")
    end
    it "picks up false" do
      matched_value = "VECTOR=.FALSE.', someother stuff".match(described_class::LOGICAL)[:value]

      expect(matched_value).to eql("FALSE")
    end
  end

  describe "cast_logical" do
    it "converts 'TRUE' to boolean" do
      boolean = described_class.cast_logical("TRUE")
      expect(boolean).to be(true)
    end
  end

  describe "REAL_ARRAY" do
    it "picks up all values numbers" do
      matched_value = "GVEC=1.4,0.,-9.81".match(described_class::REAL_ARRAY)[:value]

      expect(matched_value).to eql("1.4,0.,-9.81")
    end
  end
end
