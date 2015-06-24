require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:valid_course){ create(:course) }
  let(:build_course){ build(:course) }

  describe "Validation" do
    context "has a valid factory" do
      it "is valid" do
        expect(valid_course).to be_valid
      end
    end

    context "with invalid data" do
      context "studio_id with emtpy field" do
        before :each do
          build_course.studio_id = nil
        end

        it "is invalid" do
          expect(build_course).to be_invalid
        end

        it "error message is present" do
          build_course.save
          expect(build_course.errors.messages[:studio_id]).to be_present
        end
      end

      context "style_id with emtpy field" do
        before :each do
          build_course.style_id = nil
        end

        it "is invalid" do
          expect(build_course).to be_invalid
        end

        it "error message is present" do
          build_course.save
          expect(build_course.errors.messages[:style_id]).to be_present
        end
      end

      context "ending with emtpy field" do
        before :each do
          build_course.ending = nil
        end

        it "is invalid" do
          expect(build_course).to be_invalid
        end

        it "error message is present" do
          build_course.save
          expect(build_course.errors.messages[:ending]).to be_present
        end
      end

      context "start with emtpy field" do
        before :each do
          build_course.start = nil
        end

        it "is invalid" do
          expect(build_course).to be_invalid
        end

        it "error message is present" do
          build_course.save
          expect(build_course.errors.messages[:start]).to be_present
        end
      end
    end


  end

end
