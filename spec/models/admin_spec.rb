require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:valid_admin){ create(:admin) }
  let(:build_admin){ build(:admin) }

  describe "Before creates record" do
    context "trimms field" do
      it "name" do
        build_admin.name = " admin "
        build_admin.save
        expect(build_admin.name).to eq 'admin'
      end

      it "password" do
        build_admin.name = " 123qwe! "
        build_admin.save
        expect(build_admin.name).to eq '123qwe!'
      end
    end
  end

  describe "Validation" do
    context "with valid factory" do
      it "is valid" do
        expect(valid_admin).to be_valid
      end
    end

  describe "with invalid attributes."
    context "name" do
      context "is to long" do
        before :each do
          build_admin.name = 'a' * 55
          build_admin.save
        end

        it "is invalid" do
          expect(build_admin).to be_invalid
        end

        it "error message is present" do
          expect(build_admin.errors.messages[:name]).to be_present
        end
      end

      context "has empty field" do
        before :each do
          build_admin.name = ''
          build_admin.save
        end

        it "is invalid" do
          expect(build_admin).to be_invalid
        end

        it "error message is present" do
          expect(build_admin.errors.messages[:name]).to be_present
        end
      end

      context "is unique" do
        before :each do
          valid_admin
          build_admin.save
        end
        it "is invalid" do
          expect(build_admin).to be_invalid
        end

        it "has erros message: 'has already been taken'" do
          expect(build_admin.errors.messages[:name]).to include 'has already been taken'
        end
      end
    end

    context "Password" do
      context "with empty field" do
        let(:empty_password){ build(:admin, name: 'admin', password: '') }

        it "is invalid" do
          expect(empty_password).to be_invalid
        end

        it "error message is present" do
          empty_password.valid?
          expect(empty_password.errors.messages[:password]).to be_present
        end
      end

      context "is to short" do
        let(:short_password){ build(:admin, name: 'admin', password: 'qwe23') }

        it "is invalid" do
          expect(short_password).to be_invalid
        end

        it "error message is present" do
          short_password.valid?
          expect(short_password.errors.messages[:password]).to be_present
        end
      end

      context "is to long" do
        let(:long_password){ build(:admin, password: "#{ 'a' * 20 }12!") }

        it "it is invalid" do
          expect(long_password).to be_invalid
        end

        it "starts with error message: 'is too long...'" do
          long_password.valid?
          expect(long_password.errors.messages[:password]).to start_with /is too long/
        end
      end

      context "password strength" do
        let(:strength_password){ build(:admin, name: 'admin', password: '') }

        it "is invalid for 123456" do
          strength_password.password = "123456"
          expect(strength_password).to be_invalid
        end

        it "is invalid for qweasd" do
          strength_password.password = "qweasd"
          expect(strength_password).to be_invalid
        end

        it "is invalid for 123qwe" do
          strength_password.password = "123qwe"
          expect(strength_password).to be_invalid
        end

        it "is invalid for qwe%&/" do
          strength_password.password = "qwe%&/"
          expect(strength_password).to be_invalid
        end

        it "error message is present" do
          strength_password.password = "qwe%&/"
          strength_password.valid?
          expect(strength_password.errors.messages[:password]).to be_present
        end
      end
    end

  end

end
