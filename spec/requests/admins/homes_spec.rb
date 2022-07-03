require 'rails_helper'

RSpec.describe "Admins::Homes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admins/homes/index"
      expect(response).to have_http_status(:success)
    end
  end

end
