require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_one(:address) }
    it { should have_one(:company) }
  end

  describe 'validations' do
    it "should validate address (validates_associated)" do
      a = User.new(first_name:"ruby", last_name:"rails", email_address: "test@chimera.com")
      a.build_address(street:"abc")
      a.save.should eq(false)
    end

    it { should validate_presence_of(:first_name)}
    it { should validate_presence_of(:last_name)}
    it { should validate_presence_of(:email_address)}

    context 'email_address validations' do
      let(:user) { User.new(first_name:"ruby", last_name:"rails") }

      it 'should be invalid' do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          user.email_address = invalid_address
          expect(user).not_to be_valid
        end
      end

      it 'should be valid' do
        addresses = %w[user@foo.com user_at_foo@www.org example.user@foo.com foo+2@barbaz.com]
        addresses.each do |valid_address|
          user.email_address = valid_address
          expect(user).to be_valid
        end
      end
    end

    context 'date_of_birth' do
      let(:user) { User.new(first_name:"ruby", last_name:"rails", email_address:"test@chimera.com") }

      it 'should be valid' do
        birth = %w[20.12.2009 2017.12.01]
        birth.each do |invalid_address|
          user.date_of_birth = invalid_address
          expect(user).to be_valid
        end
      end

      it 'should be invalid' do
        birth = %W[20.12.2020 2020.12.01 2012.15.01 qdwqw moja_daatat fwe.qd12.10 #{Date.today}]
        birth.each do |invalid_address|
          user.date_of_birth = invalid_address
          expect(user).not_to be_valid
        end
      end
    end

    it { should validate_length_of(:first_name).is_at_most(100) }
    it { should validate_length_of(:last_name).is_at_most(100) }

    context 'matching_numer_to_country' do
      let(:user) { User.new(first_name:"ruby", last_name:"rails", email_address:"test@chimera.com") }
      before(:each) { user.save; user.create_address!(street: "qwerty", city: "qazwsx", zip_code: "87-100", country: "poland" ) }

      context 'should be valid' do
          it 'when phone_number is nil' do
            user.phone_number = nil
            expect(user).to be_valid
          end

          it 'when phone_number is empty' do
            user.phone_number = ""
            expect(user).to be_valid
          end

          it 'valid phone number' do
            user.phone_number = "123123123"
            expect(user).to be_valid
          end

          it 'valid phone number with +48' do
            user.phone_number = "+48123123123"
            expect(user).to be_valid
          end

          it 'valid phone number with +48 and -' do
            user.phone_number = "+48-123-123-123"
            expect(user).to be_valid
          end

        context 'should be invalid' do
          it 'when phone number doesnt match to country' do
            user.phone_number = "1231231233"
            expect(user).not_to be_valid
          end

          it 'has error messages' do
            user.phone_number = "1231231233"
            user.save
            expect(user.errors.messages.first.last).to eq ["phone doesn't match to country"]
          end
        end
      end
    end

  end

  describe 'nested_attributes' do
    it { should accept_nested_attributes_for(:address) }
    it { should accept_nested_attributes_for(:company) }
  end
end
