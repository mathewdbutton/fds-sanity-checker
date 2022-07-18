require 'rails_helper'

RSpec.describe ValidationRunsController, type: :controller do
  describe 'any_action' do
    it 'runs the validation clean class' do
      allow(ValidationCleanup).to receive(:call)
      get :show
      expect(ValidationCleanup).to have_received(:call)
    end
  end
end
