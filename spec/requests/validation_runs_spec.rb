require 'rails_helper'

RSpec.describe "ValidationRuns", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/validation_runs/show"
      expect(response).to have_http_status(:success)
    end
  end

end
