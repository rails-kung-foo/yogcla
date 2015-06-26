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

    context "with invalid data." do
      context "Must be present" do
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

        context "weekday with emtpy field" do
          before :each do
            build_course.weekday = nil
          end

          it "is invalid" do
            expect(build_course).to be_invalid
          end

          it "error message is present" do
            build_course.save
            expect(build_course.errors.messages[:weekday]).to be_present
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

          it "includes errors messages: wrong length" do
            expect(build_course.errors.messages[:ending][1]).to include "wrong length"
          end
        end

        context "ending has wrong format" do
          it "00.00 is not valid" do
            build_course.ending = "00.00"
            expect(build_course).to be_invalid
          end

          it "00a00 is not valid" do
            build_course.ending = "00a00"
            expect(build_course).to be_invalid
          end
        end

        context "start is to short" do
          before :each do
            build_course.start = "11:1"
            build_course.valid?
          end

          it "is not valid" do
            expect(build_course).to be_invalid
          end

          it "includes errors messages: wrong length" do
            expect(build_course.errors.messages[:start][1]).to include "wrong length"
          end
        end

        context "start has wrong format" do
          it "00.00 is not valid" do
            build_course.start = "00.00"
            expect(build_course).to be_invalid
          end

          it "00a00 is not valid" do
            build_course.start = "00a00"
            expect(build_course).to be_invalid
          end
        end
      end
    end
    # END OF context with invalid data.

    context "only weekdays allowed for :weekday" do
      it "fuzzbuzz is invalid" do
        build_course.weekday = 'fuzzbuzz'
        expect(build_course).to be_invalid
      end

      ApplicationHelper::WEEKDAYS.each do |weekday|
        it "#{ weekday } is valid" do
          build_course.weekday = weekday
          expect(build_course).to be_valid
        end
      end
    end
  end
  # END OF describe Validation

  describe "Trimms field" do
    let(:example_time){ ' 00:40 ' }

    it "from start" do
      build_course.start = example_time
      expect(build_course).to be_valid
      expect(build_course.start).to eq example_time.strip
    end

    it "from ending" do
      build_course.ending = example_time
      expect(build_course).to be_valid
      expect(build_course.ending).to eq example_time.strip
    end
  end

  describe "methods" do
    before :each do
      valid_course
    end

    context ".by_weekday" do
      it "finds one record" do
        expect(Course.by_weekday('monday').count).to be 1
      end

      it "finds two records" do
        build_course.save
        expect(Course.by_weekday('monday').count).to be 2
      end
    end

    context ".latest" do
      before :each do
        build_course.save
      end

      it "returns latest updated record" do
        expect(Course.latest).to eq build_course
      end

      it "returns :valid_course, the latest updated" do
        valid_course.weekday = 'sunday'
        valid_course.save
        expect(Course.latest).to eq valid_course
      end
    end

    context ".filter_by" do
        before :each do
        valid_course
        create(:studio)
        create(:studio, name: 'sun')
        create(:style)
        create(:style, stil: 'zen')

        second_course = create(:course,
          weekday: 'saturday',
          style_id: 2)
        third_course = create(:course,
          weekday: 'monday',
          studio_id: 2)
      end

      it "with no param finds all" do
        expect(Course.filter_by).to eq Course.all
      end

      it "day: 'monday'  finds 2" do
        expect(Course.filter_by(day: 'monday').count).to eq 2
      end

      it "studio: 'sun' finds 1" do
        expect(Course.filter_by(studio: 'sun').count).to eq 1
      end

      it "style: 'zen' finds 1" do
        expect(Course.filter_by(style: 'zen').count).to eq 1
      end

      it "day: 'monday', style: 'ashtanga' find 2" do
        expect(Course.filter_by(day: 'monday', style: 'ashtanga').count).to eq 2
      end

      it "day: 'monday', style: 'ashtanga', studio: 'Yoga Studio' find 1" do
        expect(Course.filter_by(day: 'monday', style: 'ashtanga', studio: 'Yoga Studio').count).to eq 1
      end

    end

    context "#studio_name" do
      it "it returns the name Yoga Studio" do
        create :studio
        expect(valid_course.studio_name).to eq 'Yoga Studio'
      end
    end

    context "#style_name" do
      it "it returns the stil ashtanga" do
        create :style
        expect(valid_course.style_name).to eq 'ashtanga'
      end
    end
  end
end
