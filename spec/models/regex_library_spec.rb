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
end
