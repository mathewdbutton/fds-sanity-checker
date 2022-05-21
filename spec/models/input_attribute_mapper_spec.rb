require "rails_helper"

RSpec.describe InputAttributeMapper do
  let!(:mock_class) do
    Class.new do
      extend InputAttributeMapper

      map_attribute :THIS_IS_A_TEST_METHOD, /(?<value>some_value)/
      map_attribute :will_not_find_a_thing, /nope/

      def raw_attributes
        "THIS_IS_A_TEST_METHOD=some_value"
      end
    end
  end
  describe ".map_attributes" do
    it "creates the methods" do
      expect(mock_class.new.methods).to include(:this_is_a_test_method)
    end

    it "applies the regex and finds the value" do
      expect(mock_class.new.this_is_a_test_method).to eq("some_value")
    end

    context 'when argument is missing' do
      it 'returns nil for the value' do
        expect(mock_class.new.will_not_find_a_thing).to be_nil
      end
    end
  end
end
