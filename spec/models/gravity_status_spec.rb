require 'rails_helper'

RSpec.describe GravityStatus do
  describe 'validation' do
    let(:validation_run) { create(:validation_run) }

    it 'is valid' do
      misc = create(:misc, validation_run: validation_run, gvec_x:2.0, gvec_z: 9.603962723792716, gvec_y: 0)

      status = described_class.new(validation_run)

      expect(status).to be_valid
    end

    context 'when y is not zero' do
      it 'is invalid' do
        misc = create(:misc, validation_run: validation_run, gvec_x:2.0, gvec_z: 9.603962723792716, gvec_y: 4)

        status = described_class.new(validation_run)

        expect(status).to be_invalid
        expect(status.errors.messages).to eql({gvec_y: ["must be equal to zero. Altering gravity on the y plane has no effect the model."]})
      end
    end

    context 'when the resulting gvec vector does not add to gravity' do
      it 'is invalid' do
        misc = create(:misc, validation_run: validation_run, gvec_x:2.0, gvec_z: 2, gvec_y: 0)

        status = described_class.new(validation_run)

        expect(status).to be_invalid
        expect(status.errors.messages).to eql({base: ["GVEC vector should be 9.81"]})
      end
    end
  end
end
