require 'rails_helper'

RSpec.describe SupplyExhaustStatus do
  let(:validation_run) { create(:validation_run) }
  describe 'validation' do

    context "when net volume flow is not zero" do
      before(:each) do
        surface_1 = create(:surface, volume_flow: 0.1, validation_run: validation_run)
        surface_2 = create(:surface, volume_flow: -0.1, validation_run: validation_run)
        create_list(:vent,2, surface: surface_1, validation_run: validation_run)
        create_list(:vent,3, surface: surface_2, validation_run: validation_run)
      end

      it "is invalid" do
        status_model = described_class.new(validation_run)

        aggregate_failures do
          expect(status_model).to be_invalid
          expect(status_model.errors.messages[:net_volume_flow]).to contain_exactly('must be equal to 0')
        end
      end
    end

    context "when net volume is zero" do
      before(:each) do
        surface_1 = create(:surface, volume_flow: 0.1, validation_run: validation_run)
        surface_2 = create(:surface, volume_flow: -0.1, validation_run: validation_run)
        create(:vent, surface: surface_1, validation_run: validation_run)
        create(:vent, surface: surface_2, validation_run: validation_run)
      end

      it "is valid" do
        status_model = described_class.new(validation_run)

        expect(status_model).to be_valid
      end
    end
  end

  describe '#total_supply' do
    it 'returns the correct value' do
      surface_1 = create(:surface, volume_flow: 0.1, validation_run: validation_run)
      surface_2 = create(:surface, volume_flow: -0.1, validation_run: validation_run)
      create_list(:vent,2, surface: surface_1, validation_run: validation_run)
      create_list(:vent,3, surface: surface_2, validation_run: validation_run)

      status_model = described_class.new(validation_run)

      expect(status_model.total_supply).to eql(-0.3)
    end
  end
  describe '#total_demand' do
    it 'returns the correct value' do
      surface_1 = create(:surface, volume_flow: 0.1, validation_run: validation_run)
      surface_2 = create(:surface, volume_flow: -0.1, validation_run: validation_run)
      create_list(:vent,2, surface: surface_1, validation_run: validation_run)
      create_list(:vent,3, surface: surface_2, validation_run: validation_run)

      status_model = described_class.new(validation_run)

      expect(status_model.total_demand).to eql(0.2)
    end
  end
  describe '#net_volume_flow' do
    it 'returns the correct value' do
      surface_1 = create(:surface, volume_flow: 0.1, validation_run: validation_run)
      surface_2 = create(:surface, volume_flow: -0.1, validation_run: validation_run)
      create_list(:vent,2, surface: surface_1, validation_run: validation_run)
      create_list(:vent,3, surface: surface_2, validation_run: validation_run)

      status_model = described_class.new(validation_run)

      expect(status_model.net_volume_flow).to eql(-0.1)
    end
  end
end
