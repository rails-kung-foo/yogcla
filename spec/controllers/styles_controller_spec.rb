require 'rails_helper'

RSpec.describe StylesController, type: :controller do
  let(:new_style){ create(:style) }
  let(:create_admin) { create(:admin) }
  let(:session) { { admin_id: create_admin.id } }

  describe "GET #index" do
    before :each do
      get :index
    end

    it "is successful" do
      expect(response.status).to eq 200
    end

    it "populates array to @styles" do
      new_style
      expect(assigns(:styles)).to match_array new_style
    end

    it "renders template :index" do
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

    it "renders template :show" do
      expect(response).to render_template :show
    end

    it "assigns the requested record to @style" do
      expect(assigns(:style)).to eq new_style
    end
  end

  describe 'GET #new' do
    context "with no admin session" do
      before :each do
        get :new
      end

      it "redirects to login_url" do
        expect(response).to redirect_to login_url
      end

      it "flashn notice is 'Please Log In'" do
        expect(flash[:notice]).to eq "Please Log In"
      end
    end

    context "when admin is logged in" do
      before :each do
        create_admin
        get :new, nil, session
      end

      it "is successful" do
        expect(response).to have_http_status :success
      end

      it "renders template :new" do
        expect(response).to render_template :new
      end

      it "assigns new style to @style" do
        expect(assigns(:style)).to be_a_new Style
      end
    end

  end
end
