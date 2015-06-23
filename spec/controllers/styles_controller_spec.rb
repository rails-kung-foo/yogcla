require 'rails_helper'

RSpec.describe StylesController, type: :controller do
  let(:new_style){ create(:style) }

  describe "GET #index" do
    before :each do
      get :index
    end

    it "is successful" do
      expect(response.status).to eq 200
    end

    it "populates array of stils" do
      expect(assigns(:styles)).to eq [new_style]
    end

    it "renders the index template" do
      expect(response).to render_template :index
    end
  end
end
