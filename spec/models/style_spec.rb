require 'rails_helper'

RSpec.describe Style, type: :model do
  it "it downcases the stil" do
    style_name = 'BIKRaM'
    style = create(:style, stil: style_name)
    expect(style.stil).to eq style_name.downcase
  end

  it "trimms whitespaces from stil" do
    style = create(:style, stil: ' test ')
    expect(style.stil).to eq 'test'
  end

  describe "Validation" do
    it "has a valid factory" do
      expect(create(:style)).to be_valid
    end

    it "is invalid with an empty field" do
      style = build(:style, stil: nil)
      expect(style).to be_invalid
    end

    it "is unique" do
      first_style = create(:style)
      second_style = build(:style)
      expect(second_style).to be_invalid
    end
  end

  describe "methods" do
    before :each do
      @first = create(:style)
      @second = create(:style, stil: 'zen')
    end

    it "Style.stil_by returns matched record" do
      style = Style.by_stil('zen')
      expect(style.first.id).to eq @second.id
      expect(style.count).to be 1
    end

    it "Style.latest returns the last updated_at record" do
      latest = Style.latest
      expect(latest.id).to eq @second.id
    end
  end
end
