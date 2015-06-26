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
      context "empty field:" do
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

      context "validates time" do
        context "ending is to short" do
          before :each do
            build_course.ending = "11:1"
            build_course.valid?
          end

          it "is not valid" do
            expect(build_course).to be_invalid
          end

          it "has errors messages:" do
            expect(build_course.errors.messages[:ending][1]).to include "wrong length"
          end
        end

        context "with wrong format" do
          it "00.00 is not valid" do
            build_course.ending = "00.00"
            expect(build_course).to be_invalid
          end

          it "00a00 is not valid" do
            build_course.ending = "00a00"
            expect(build_course).to be_invalid
          end
        end


      end


    end


  end

end
