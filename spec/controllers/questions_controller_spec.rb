require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #trade" do
    it "returns http success" do
      get :trade
      expect(response).to have_http_status(:success)
    end
  end

end
