require 'rails_helper'

RSpec.describe RelationsController, type: :controller do

  describe "GET #apply" do
    it "returns http success" do
      get :apply
      expect(response).to have_http_status(:success)
    end
  end

end
