require 'rails_helper'

RSpec.describe ValidationCleanup, type: :model do
  describe '#call' do
    context '' do
      it 'deletes all the validation runs before the date' do
        create(:validation_run, created_at: Time.current.yesterday, updated_at: Time.current.yesterday)
        create(:validation_run, created_at: Time.current.yesterday, updated_at: Time.current.yesterday)
        create(:validation_run, created_at: Time.current.midnight + 1.second,
                                updated_at: Time.current.midnight + 1.second)

        expect do
          described_class.new(beginning_at: Time.current.midnight).call
        end.to change(ValidationRun, :count).from(3).to(1)
      end

      context 'when there are no validations to delete' do
        it 'is a no-op' do
          expect do
            described_class.new(beginning_at: Time.current.midnight).call
          end.not_to change(ValidationRun, :count)
        end
      end
    end
  end
end
