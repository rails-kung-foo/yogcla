require 'rails_helper'

RSpec.describe Style, type: :model do
  let(:valid_style){ create(:style) }

  describe "before create" do
    it "is downcases the stil" do
      style_name = 'BIKRaM'
      style = create(:style, stil: style_name)
      expect(style.stil).to eq style_name.downcase
    end

    it "trimms whitespaces from stil" do
      style = create(:style, stil: ' test ')
      expect(style.stil).to eq 'test'
    end
  end

  describe "ActiveModel validation" do
   it "has a valid factory" do
      expect(valid_style).to be_valid
    end

    it "is invalid with an empty field" do
      style = build(:style, stil: nil)
      expect(style).to be_invalid
    end

    it "is unique" do
      valid_style
      second_style = build(:style)
      expect(second_style).to be_invalid
    end
  end

  describe "Methods" do
    let(:second_record) { create(:style, stil: 'zen') }
    before :each do
      valid_style
      second_record
    end

    it "Style.stil_by returns matched record" do
      style = Style.by_stil('zen')
      expect(style.first.id).to eq second_record.id
      expect(style.count).to be 1
    end

    it "Style.latest returns the last updated_at record" do
      latest = Style.latest
      expect(latest.id).to eq second_record.id
    end
  end
end
