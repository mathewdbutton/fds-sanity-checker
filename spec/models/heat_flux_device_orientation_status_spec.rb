require 'rails_helper'

RSpec.describe HeatFluxDeviceOrientationStatus do
  let(:validation_run) { create(:validation_run) }

  describe "validations" do
    it "is valid" do
      create(:device, orientation: "0,0,1", quantity: "RADIATIVE HEAT FLUX", validation_run: validation_run )

      status_model = described_class.new(validation_run)

      expect(status_model).to be_valid
      expect(status_model.errors.full_messages).to contain_exactly()
    end

    context "when there are no heat flux devices present" do
      it "is invalid" do
      status_model = described_class.new(validation_run)

      expect(status_model).to be_invalid
      expect(status_model.errors.messages[:base]).to contain_exactly("At least one Radiative Heat Flux device must be present")
      end
    end

    context "when a heat flux device is not the correct orienation" do
      it "is invalid" do
      create(:device, orientation: "0,0,1", quantity: "RADIATIVE HEAT FLUX", validation_run: validation_run )
      create(:device, orientation: "0,0,-1", quantity: "RADIATIVE HEAT FLUX", validation_run: validation_run )

      status_model = described_class.new(validation_run)

      expect(status_model).to be_invalid
      expect(status_model.errors.messages[:base]).to contain_exactly("All Radiative Heat Flux devices must be facing up (0,0,1)")
      end
    end
  end

end
