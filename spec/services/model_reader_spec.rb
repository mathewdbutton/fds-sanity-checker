require 'rails_helper'

RSpec.describe ModelReader do
  let(:test_file) { fixture_file_upload("test.fds") }

  describe '#call' do
    it 'returns the list of strings' do
      temp_file = StringIO.new("test\nfile\n")

      lines = described_class.new(temp_file).call

      expect(lines).to eql("test\nfile\n")
    end

    it 'returns a multiple lines' do
      test_file = StringIO.new("&SLCF XPB=0.02 / \n &SURF ID='SUCK',\n THING='YEP', \nCOLOR='RED' /")

      e = described_class.new(test_file).each

      aggregate_failures do
        expect(e.next).to eql("&SLCF XPB=0.02 / \n")
        expect(e.next).to eql(" &SURF ID='SUCK',\n THING='YEP', \nCOLOR='RED' /")
      end
    end
  end
end
