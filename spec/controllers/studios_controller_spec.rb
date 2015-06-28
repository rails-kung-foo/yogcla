require 'rails_helper'

RSpec.describe StudiosController, type: :controller do
  let(:new_studio){ create(:studio) }
  let(:create_admin) { create(:admin) }
  let(:session) { { admin_id: create_admin.id } }

  describe "GET #index" do
    before :each do
      get :index
    end

    it "is successful" do
      expect(response.status).to eq 200
    end

    it "populates array to @studios" do
      new_studio
      expect(assigns(:studios)).to match_array new_studio
    end

    it "renders template :index" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before :each do
      new_studio
      get :show, id: new_studio
    end

    it "is successful" do
      expect(response.status).to eq 200
    end

    it "renders template :show" do
      expect(response).to render_template :show
    end

    it "assigns the requested record to @studio" do
      expect(assigns(:studio)).to eq new_studio
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

      it "flash notice is 'Please Log In'" do
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

      it "assigns new studio to @studio" do
        expect(assigns(:studio)).to be_a_new Studio
      end
    end
  end

  describe "GET #edit" do
    context "with no admin session" do
      before :each do
        new_studio
        get :edit, id: new_studio
      end

      it "redirects to login_url" do
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        expect(flash[:notice]).to eq "Please Log In"
      end
    end

    context "admin is logged in" do
      before :each do
        create_admin
        new_studio
        get :edit, { id: new_studio }, session
      end

      it "is successful" do
        expect(response).to have_http_status :success
      end

      it "renders template :edit" do
        expect(response).to render_template :edit
      end

      it "assigns new studio to @studio" do
        expect(assigns(:studio)).to eq new_studio
      end
    end
  end

  describe "POST #create" do
    context "with no admin session" do
      before :each do
        post :create, studio: attributes_for(:studio)
      end

      it "redirects to login_url" do
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        expect(flash[:notice]).to eq "Please Log In"
      end

      it "saves not into db" do
        expect{
          post :create, attributes_for(:studio)
        }.to change(Studio, :count).by(0)
      end
    end

    context 'admin is logged in' do
      before :each do
        create_admin
      end

      context "with valid params" do
        let(:post_valid_create) {
          post :create, { studio: attributes_for(:studio) }, session
        }

        it "redirects to new records page" do
          post_valid_create
          expect(response).to redirect_to Studio.last
        end

        it "flash notices 'Studio was successfully created.'" do
          post_valid_create
          expect(flash[:notice]).to eq 'Studio was successfully created.'
        end

        it "increase db by 1" do
          expect{
            post_valid_create
          }.to change(Studio, :count).by(1)
        end
      end

      context "with invalid params" do
        let(:post_invalid_create) {
          post :create, { studio: { name: nil, adress: nil } }, session
        }

        it "redirects to new records page" do
          post_invalid_create
          expect(response).to render_template :new
        end

        it "increase not db" do
          expect{
            post_invalid_create
          }.to change(Studio, :count).by(0)
        end
      end
    end
  end

  describe "PUT #update" do
    context "with no admin session" do
      before :each do
        new_studio
        put :update, id: new_studio, studio: attributes_for(:studio)
      end

      it "redirects to login_url" do
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        expect(flash[:notice]).to eq "Please Log In"
      end

      it "record is untouched." do
        expect(new_studio).to eq new_studio
      end
    end

    context "admin is logged in" do
      context "with valid params" do
        before :each do
          new_studio
          put :update, { id: new_studio, studio:  attributes_for(:studio) }, session
        end

        it "redirect to records page" do
          expect(response).to redirect_to new_studio
        end

        it "flash notice is 'Studio was successfully updated.'" do
          expect(flash[:notice]).to eq 'Studio was successfully updated.'
        end

        it "saves changes in DB" do
          new_studio.reload
          expect(new_studio.name).to eq attributes_for(:studio)[:name]
        end
      end

      context "with invalid params" do
        before :each do
          new_studio
          put :update, { id: new_studio, studio:{ name: nil } }, session
        end

        it "renders template :edit" do
          expect(response).to render_template :edit
        end

        it "changes not the record" do
          new_studio.reload
          expect(new_studio.name).to eq attributes_for(:studio)[:name]
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "with no admin session" do
      before :each do
        new_studio
      end

      it "redirects to login_url" do
        delete :destroy, id: new_studio
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        delete :destroy, id: new_studio
        expect(flash[:notice]).to eq "Please Log In"
      end

      it "record is untouched." do
        expect{
          delete :destroy, id: new_studio
        }.to change(Studio, :count).by(0)
      end
    end

    context "admin is logged in" do
      before :each do
        new_studio
      end

      it "redirects to login_url" do
        delete :destroy, { id: new_studio }, session
        expect(response).to redirect_to studios_url
      end

      it "flash notices 'Studio was successfully destroyed.'" do
        delete :destroy, { id: new_studio }, session
        expect(flash[:notice]).to eq 'Studio was successfully destroyed.'
      end

      it "destroys the request record" do
        expect{
          delete :destroy, { id: new_studio }, session
        }.to change(Studio, :count).by(-1)
      end
    end
  end


end
