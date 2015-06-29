require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:new_course){ create(:course, params) }
  let(:new_studio){ create(:studio) }
  let(:new_style){ create(:style) }
  let(:create_admin) { create(:admin) }
  let(:session) { { admin_id: create_admin.id } }
  let(:params){ { studio_id: new_studio.name, style_id: new_style.stil,
      start: '10:00', ending: '11:00', weekday: 'monday' }
  }

  describe "GET #index" do
    describe "without params" do
      before :each do
        get :index
      end

      it "is successful" do
        expect(response.status).to eq 200
      end

      it "populates array to @courses" do
        new_course
        expect(assigns(:courses)).to match_array new_course
      end

      it "renders template :index" do
        expect(response).to render_template :index
      end
    end

    describe "with params" do
      let(:zen_style){ create :zen_style }
      let(:sun_yoga){ create :sun_yoga }
      let(:second_course){ create :second_course }
      let(:third_course){ create :third_course }


      before :each do
        new_studio
        new_style
        new_course
        zen_style
        sun_yoga
        second_course
        third_course
      end

      it "params[filter_weekday]: 'sunday' returns an array of
        [second_course, third_course]" do
        get :index, filter_weekday: 'sunday'
        expect(assigns(:courses)).to match_array([second_course, third_course])
      end

      it "params[filter_weekday]: 'sunday' and [filter_style]: 'zen' returns an
        array of [second_course]" do
        get :index, filter_weekday: 'sunday', filter_style: 'zen'
        expect(assigns(:courses)).to match_array([third_course])
      end

      it "params[filter_weekday]: 'sunday', [filter_style]: 'ashtanga',
        [filter_studio]: 'Sun Yoga' retuns array of [second_course]" do
        get :index, filter_style: 'ashtanga', filter_studio: 'Sun Yoga', filter_weekday: 'sunday'
        expect(assigns(:courses)).to match_array([second_course])
      end

    end
  end

  describe "GET #show" do
    before :each do
      new_course
      get :show, id: new_course
    end

    it "is successful" do
      expect(response.status).to eq 200
    end

    it "renders template :show" do
      expect(response).to render_template :show
    end

    it "assigns the requested record to @course" do
      expect(assigns(:course)).to eq new_course
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

      it "assigns new course to @course" do
        expect(assigns(:course)).to be_a_new Course
      end
    end
  end

  describe "GET #edit" do
    context "with no admin session" do
      before :each do
        new_course
        get :edit, id: new_course
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
        new_course
        get :edit, { id: new_course }, session
      end

      it "is successful" do
        expect(response).to have_http_status :success
      end

      it "renders template :edit" do
        expect(response).to render_template :edit
      end

      it "assigns new course to @course" do
        expect(assigns(:course)).to eq new_course
      end
    end
  end

  describe "POST #create" do
    context "with no admin session" do
      before :each do
        new_studio
        new_style
        post :create, course: params
      end

      it "redirects to login_url" do
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        expect(flash[:notice]).to eq "Please Log In"
      end

      it "saves not into db" do
        expect{
          post :create, attributes_for(:course)
        }.to change(Course, :count).by(0)
      end
    end

    context 'admin is logged in' do
      before :each do
        create_admin
      end

      context "with valid params" do
        let(:post_valid_create) {
          post :create, { course: params }, session
        }

        it "redirects to new records page" do
          post_valid_create
          expect(response).to redirect_to Course.last
        end

        it "flash notices 'Course was successfully created.'" do
          post_valid_create
          expect(flash[:notice]).to eq 'Course was successfully created.'
        end

        it "increase db by 1" do
          expect{
            post_valid_create
          }.to change(Course, :count).by(1)
        end
      end

      context "with invalid params" do
        let(:post_invalid_create) {
          post :create, { course: { start: nil, studio_id: new_studio.name,
            style_id: new_style.stil } }, session
        }

        it "redirects to new records page" do
          post_invalid_create
          expect(response).to render_template :new
        end

        it "increase not db" do
          expect{
            post_invalid_create
          }.to change(Course, :count).by(0)
        end
      end
    end
  end

  describe "PUT #update" do
    context "with no admin session" do
      before :each do
        new_course
        put :update, id: new_course, course: { start: '22:22' }
      end

      it "redirects to login_url" do
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        expect(flash[:notice]).to eq "Please Log In"
      end

      it "record is untouched." do
        new_course.reload
        expect(new_course).to eq new_course
      end
    end

    context "admin is logged in" do
      context "with valid params" do
        let(:update_params){
          { studio_id: new_studio.name, style_id: new_style.stil,
              start: '10:00', ending: '11:00', weekday: 'sunday' }
        }

        before :each do
          new_studio
          new_style
          new_course
          put :update, { id: new_course, course: update_params }, session
        end

        it "redirect to records page" do
          expect(response).to redirect_to new_course
        end

        it "flash notice is 'Course was successfully updated.'" do
          expect(flash[:notice]).to eq 'Course was successfully updated.'
        end

        it "saves changes in DB" do
          new_course.reload
          expect(new_course.weekday).to eq 'sunday'
        end
      end

      context "with invalid params" do
        let(:update_invalid_params){
          { studio_id: new_studio.name, style_id: new_style.stil,
              start: '10:00', ending: '11:00', weekday: 'wrong' }
        }

        before :each do
          new_studio
          new_style
          new_course
          put :update, { id: new_course, course: update_invalid_params }, session
        end

        it "renders template :edit" do
          expect(response).to render_template :edit
        end

        it "changes not the record" do
          new_course.reload
          expect(new_course).to eq new_course
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "with no admin session" do
      before :each do
        new_course
      end

      it "redirects to login_url" do
        delete :destroy, id: new_course
        expect(response).to redirect_to login_url
      end

      it "flash notice is 'Please Log In'" do
        delete :destroy, id: new_course
        expect(flash[:notice]).to eq "Please Log In"
      end

      it "record is untouched." do
        expect{
          delete :destroy, id: new_course
        }.to change(Studio, :count).by(0)
      end
    end

    context "admin is logged in" do
      before :each do
        new_course
      end

      it "redirects to login_url" do
        delete :destroy, { id: new_course }, session
        expect(response).to redirect_to courses_url
      end

      it "flash notices 'Course was successfully destroyed.'" do
        delete :destroy, { id: new_course }, session
        expect(flash[:notice]).to eq 'Course was successfully destroyed.'
      end

      it "destroys the request record" do
        expect{
          delete :destroy, { id: new_course }, session
        }.to change(Course, :count).by(-1)
      end
    end
  end

end
