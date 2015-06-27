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

      it "assigns new style to @style" do
        expect(assigns(:style)).to be_a_new Style
      end
    end
  end

  describe "GET #dit" do
    context "with no admin session" do
      before :each do
        new_style
        get :edit, id: new_style
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
        new_style
        get :edit, { id: new_style }, session
      end

      it "is successful" do
        expect(response).to have_http_status :success
      end

      it "renders template :edit" do
        expect(response).to render_template :edit
      end

      it "assigns new style to @style" do
        expect(assigns(:style)).to eq new_style
      end
    end
  end

  describe "POST #create" do
    context "with no admin session" do
      before :each do
        post :create, style:{ stil: 'zen' }
      end

      it "redirects to login_url" do
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        expect(flash[:notice]).to eq "Please Log In"
      end

      it "saves not into db" do
        expect{
          post :create, attributes_for(:style)
        }.to change(Style, :count).by(0)
      end
    end

    context 'admin is logged in' do
      before :each do
        create_admin
      end

      context "with valid params" do
        let(:post_valid_create) {
          post :create, { style: attributes_for(:style) }, session
        }

        it "redirects to new records page" do
          post_valid_create
          expect(response).to redirect_to Style.last
        end

        it "flash notices 'Style was successfully created.'" do
          post_valid_create
          expect(flash[:notice]).to eq 'Style was successfully created.'
        end

        it "increase db by 1" do
          expect{
            post_valid_create
          }.to change(Style, :count).by(1)
        end
      end

      context "with invalid params" do
        let(:post_invalid_create) {
          post :create, { style: { stil: nil } }, session
        }

        it "redirects to new records page" do
          post_invalid_create
          expect(response).to render_template :new
        end

        it "increase not db" do
          expect{
            post_invalid_create
          }.to change(Style, :count).by(0)
        end
      end
    end
  end

  describe "PUT #update" do
    context "with no admin session" do
      before :each do
        new_style
        put :update, id: new_style, style:{ stil: 'zen' }
      end

      it "redirects to login_url" do
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        expect(flash[:notice]).to eq "Please Log In"
      end

      it "record is untouched." do
        expect(new_style).to eq new_style
      end
    end

    context "admin is logged in" do
      context "with valid params" do
        before :each do
          new_style
          put :update, { id: new_style, style:{ stil: 'zen' } }, session
        end

        it "redirect to records page" do
          expect(response).to redirect_to new_style
        end

        it "flash notice is 'Style was successfully updated.'" do
          expect(flash[:notice]).to eq 'Style was successfully updated.'
        end

        it "saves changes in DB" do
          new_style.reload
          expect(new_style.stil).to eq 'zen'
        end
      end

      context "with invalid params" do
        before :each do
          new_style
          put :update, { id: new_style, style:{ stil: nil } }, session
        end

        it "renders template :edit" do
          expect(response).to render_template :edit
        end

        it "changes not the record" do
          new_style.reload
          expect(new_style.stil).to eq 'ashtanga'
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "with no admin session" do
      before :each do
        new_style
      end

      it "redirects to login_url" do
        delete :destroy, id: new_style
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        delete :destroy, id: new_style
        expect(flash[:notice]).to eq "Please Log In"
      end

      it "record is untouched." do
        expect{
          delete :destroy, id: new_style
        }.to change(Style, :count).by(0)
      end
    end

    context "admin is logged in" do
      before :each do
        new_style
      end

      it "redirects to login_url" do
        delete :destroy, { id: new_style }, session
        expect(response).to redirect_to styles_url
      end

      it "flash notices 'Style was successfully destroyed.'" do
        delete :destroy, { id: new_style }, session
        expect(flash[:notice]).to eq 'Style was successfully destroyed.'
      end

      it "destroys the request record" do
        expect{
          delete :destroy, { id: new_style }, session
        }.to change(Style, :count).by(-1)
      end
    end
  end
end
