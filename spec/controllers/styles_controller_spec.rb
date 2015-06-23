require 'rails_helper'

RSpec.describe StylesController, type: :controller do
  let(:new_style){ create(:style) }
  let(:session) {  }

  describe "GET #index" do
    before :each do
      get :index
    end

    it "is successful" do
      expect(response.status).to eq 200
    end

    it "populates array of stils" do
      new_style
      expect(assigns(:styles).first.id).to eq new_style.id
      expect(assigns(:styles).first.stil).to eq new_style.stil
    end

    it "renders the :index template" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before :each do
      new_style
      get :show, id: new_style
    end

    it "is successful" do
      expect(response.status).to eq 200
    end

    it "is renders the :show template" do
      expect(response).to render_template :show
    end

    it "assigns the requested record @style" do
      expect(assigns(:style)).to eq new_style
    end
  end

  describe 'GET #new' do
    before :each do
      get :new
    end

    context "with no admin session" do
      it "redirects to login_url" do
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        expect(flash[:notice]).to eq "Please Log In"
      end
    end
  end
end
