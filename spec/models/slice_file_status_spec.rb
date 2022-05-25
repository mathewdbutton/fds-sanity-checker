require 'rails_helper'

RSpec.describe SliceFileStatus do
  let(:validation_run) { create(:validation_run) }
  describe 'validation' do
    it 'is valid' do
      create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "TEMPERATURE" )
      create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "VISIBILITY" )
      create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "VELOCITY", vector: true )

      status_model = described_class.new(validation_run)

      aggregate_failures do
        expect(status_model).to be_valid
        expect(status_model.errors.full_messages).to contain_exactly()
      end
    end

    context "when there is no temperature slice file on the z plane" do
      it "is invalid" do
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "VISIBILITY" )
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "VELOCITY", vector: true )

        status_model = described_class.new(validation_run)

      aggregate_failures do
        expect(status_model).not_to be_valid
        expect(status_model.errors.messages[:base]).to contain_exactly("Must have at least one 'Temperature' slice file on the z plane")
      end
      end
    end

    context "when there is no visibility slice file on the z plane" do
      it "is invalid" do
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "TEMPERATURE" )
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "VELOCITY", vector: true )

        status_model = described_class.new(validation_run)

        aggregate_failures do
          expect(status_model).not_to be_valid
          expect(status_model.errors.messages[:base]).to contain_exactly("Must have at least one 'Visibility' slice file on the z plane")
        end
      end
    end

    context "when there is no velocity slice file on the z plane" do
      it "is invalid" do
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "TEMPERATURE" )
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "VISIBILITY" )

        status_model = described_class.new(validation_run)

        aggregate_failures do
          expect(status_model).not_to be_valid
          expect(status_model.errors.messages[:base]).to contain_exactly("Must have at least one 'Velocity' slice file on the z plane")
        end
      end
    end

    context "when there are multiple velocity slice files and one is missing the vector flag" do
      it "is invalid" do
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "TEMPERATURE" )
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "VISIBILITY" )
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "VELOCITY" )
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "VELOCITY", vector: true )

        status_model = described_class.new(validation_run)

        aggregate_failures do
          expect(status_model).not_to be_valid
          expect(status_model.errors.messages[:base]).to contain_exactly("All 'Velocity' slice files must have 'VECTOR' set to true")
        end
      end
    end

    context "when there is one velocity slice file and it is missing the vector flag" do
      it "is invalid" do
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "TEMPERATURE" )
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "VISIBILITY" )
        create(:slice_file, validation_run: validation_run, pbz: 10.0, quantity: "VELOCITY" )

        status_model = described_class.new(validation_run)

        aggregate_failures do
          expect(status_model).not_to be_valid
          expect(status_model.errors.messages[:base]).to contain_exactly("All 'Velocity' slice files must have 'VECTOR' set to true")
        end
      end
    end
  end
end
