require 'rails_helper'

RSpec.describe Studio, type: :model do
  let(:valid_studio){ create(:studio) }
  let(:build_studio){ build(:studio) }

  describe "before create reocrd" do
    let(:trimm_example){ ' example test ' }

    context "trimms field" do
      it "for name" do
        build_studio.name = trimm_example
        build_studio.save
        expect(build_studio.name).to eq trimm_example.strip
      end

      it "for address" do
        build_studio.address = trimm_example
        build_studio.save
        expect(build_studio.address).to eq trimm_example.strip
      end

      it "for url" do
        build_studio.url = trimm_example
        build_studio.save!
        expect(build_studio.url).to eq trimm_example.strip
      end
    end
  end

  describe "Validation" do
     context "with valid data" do
       it "is valid" do
         expect(valid_studio).to be_valid
       end
     end

    context "with invalid data" do
      context "with empty attributes" do
        it "name" do
          build_studio.name = ''
          expect(build_studio).to be_invalid
        end

        it "address" do
          build_studio.address = ''
          expect(build_studio).to be_invalid
        end
      end
    end
  end

  describe "Methods" do
    let(:search_word) { 'Sun Yoga' }

    before :each do
      valid_studio
      build_studio.name = search_word
      build_studio.save!
    end

    context "Studio.by_name" do
      it "returns one matched record" do
        studio = Studio.by_name search_word
        expect(studio.first.id).to eq build_studio.id
      end
    end

    context "Studio.latest" do
      it "returns the last updated_at record" do
        studio = Studio.latest
        expect(studio.id).to eq build_studio.id
      end

      it "returns valid_studio. The last updated_at record." do
        valid_studio.name = 'Test name'
        valid_studio.save!
        studio = Studio.latest
        expect(studio.id).to eq valid_studio.id
      end
    end
  end
end
