require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  let(:create_invalid_admin) { create(:admin, name: '') }
  let(:create_admin) { create(:admin) }
  let(:session) { { admin_id: create_admin.id } }

  describe "GET #index" do
    context "with no admin session" do
      before :each do
        get :index
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
        get :index, nil, session
      end

      it "is successful" do
        expect(response.status).to eq 200
      end

      it "populates array to @admins" do
        create_admin
        expect(assigns(:admins)).to match_array create_admin
      end

      it "renders template :index" do
        expect(response).to render_template :index
      end
    end
  end

  describe "GET #show" do
    context "with no admin session" do
      before :each do
        create_admin
        get :show, id: create_admin
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
        get :show, { id: create_admin }, session
      end

      it "is successful" do
        expect(response.status).to eq 200
      end

      it "renders template :show" do
        expect(response).to render_template :show
      end

      it "assigns the requested record to @admin" do
        expect(assigns(:admin)).to eq create_admin
      end
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

      it "assigns new studio to @admin" do
        expect(assigns(:admin)).to be_a_new Admin
      end
    end
  end

  describe "GET #edit" do
    context "with no admin session" do
      before :each do
        create_admin
        get :edit, id: create_admin
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
        get :edit, { id: create_admin }, session
      end

      it "is successful" do
        expect(response).to have_http_status :success
      end

      it "renders template :edit" do
        expect(response).to render_template :edit
      end

      it "assigns new studio to @studio" do
        expect(assigns(:admin)).to eq create_admin
      end
    end
  end

  describe "POST #create" do
    context "with no admin session" do
      before :each do
        post :create, admin: attributes_for(:admin)
      end

      it "redirects to login_url" do
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        expect(flash[:notice]).to eq "Please Log In"
      end

      it "saves not into db" do
        expect{
          post :create, attributes_for(:admin)
        }.to change(Studio, :count).by(0)
      end
    end

    context 'admin is logged in' do
      before :each do
        create_admin
      end

      context "with valid params" do
        let(:valid_params){ attributes_for(:admin, name: 'second') }
        let(:post_valid_create) {
          post :create, { admin: valid_params }, session
        }

        it "redirects to new admins_url" do
          post_valid_create
          expect(response).to redirect_to admins_url
        end

        it "flash notices 'Admin was successfully created.'" do
          post_valid_create
          expect(flash[:notice]).to eq 'Admin was successfully created.'
        end

        it "increase db by 1" do
          expect{
            post_valid_create
          }.to change(Admin, :count).by(1)
        end
      end

      context "with invalid params" do
        let(:post_invalid_create) {
          post :create, { admin: { name: nil } }, session
        }

        it "redirects to new records page" do
          post_invalid_create
          expect(response).to render_template :new
        end

        it "increase not db" do
          expect{
            post_invalid_create
          }.to change(Admin, :count).by(0)
        end
      end
    end
  end

  describe "PUT #update" do
    context "with no admin session" do
      before :each do
        create_admin
        put :update, id: create_admin, admin: { name: 'sun' }
      end

      it "redirects to login_url" do
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        expect(flash[:notice]).to eq "Please Log In"
      end

      it "record is untouched." do
        create_admin.reload
        expect(create_admin).to eq create_admin
      end
    end

    context "admin is logged in" do
      context "with valid params" do
        before :each do
          create_admin
          put :update, { id: create_admin,
            admin: attributes_for(:admin, name: 'test')  }, session
        end

        it "redirect to admins_url" do
          expect(response).to redirect_to admins_url
        end

        it "flash notice is 'Admin was successfully updated.'" do
          expect(flash[:notice]).to eq 'Admin was successfully updated.'
        end

        it "saves changes in DB" do
          create_admin.reload
          expect(create_admin.name).to eq 'test'
        end
      end

      context "with invalid params" do
        before :each do
          create_admin
          put :update, { id: create_admin,
            admin: attributes_for(:admin, name: '')  }, session
        end

        it "renders template :edit" do
          expect(response).to render_template :edit
        end

        it "changes not the record" do
          create_admin.reload
          expect(create_admin.name).to eq create_admin.name
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "with no admin session" do
      before :each do
        create_admin
      end

      it "redirects to login_url" do
        delete :destroy, id: create_admin
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        delete :destroy, id: create_admin
        expect(flash[:notice]).to eq "Please Log In"
      end

      it "record is untouched." do
        expect{
          delete :destroy, id: create_admin
        }.to change(Studio, :count).by(0)
      end
    end

    context "admin is logged in" do
      context "DB has more then one admin" do
        let(:second_admin) { create(:admin, name: 'second') }

        before :each do
          create_admin
          second_admin
        end

        it "redirects to admins_url" do
          delete :destroy, { id: create_admin }, session
          expect(response).to redirect_to admins_url
        end

        it "flash notices 'Admin was successfully destroyed.'" do
          delete :destroy, { id: create_admin }, session
          expect(flash[:notice]).to eq 'Admin was successfully destroyed.'
        end

        it "destroys the request record" do
          expect{
            delete :destroy, { id: create_admin }, session
          }.to change(Admin, :count).by(-1)
        end
      end

      context "DB has one admin" do
        before :each do
          create_admin
        end

        it "redirects to admins_url" do
          delete :destroy, { id: create_admin }, session
          expect(response).to redirect_to admins_url
        end

        it "flash notices 'Last admin is not deletable.'" do
          delete :destroy, { id: create_admin }, session
          expect(flash[:notice]).to eq 'Last admin is not deletable.'
        end

        it "DB is untouched" do
          expect{
            delete :destroy, { id: create_admin }, session
          }.to change(Admin, :count).by(0)
        end
      end
    end
  end

end
