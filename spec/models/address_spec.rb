require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'associations' do
    # polimorfizm jest automatycznie wykrywany
    it { should belong_to(:addressable) }
  end

  describe 'validations' do

    context 'validates_for_user' do
      let(:user) { User.new(first_name:"ruby", last_name:"rails", email_address:"test@chimera.com") }
      before(:each) { user.save }

      context 'valid' do
        it 'all attributes exist' do
          user.build_address(street:"abc", city: "qwe", zip_code:"87-100", country:"poland")
          expect(user).to be_valid
        end
        context 'for company' do
          let(:company) { user.create_company(name:"chimera") }

          it 'street is nil' do
            company.build_address(street:nil, city: "qwe", zip_code:"87-100", country:"poland")
            expect(company).to be_valid
          end

          it 'city is nil' do
            company.build_address(street:"abc", city: nil, zip_code:"87-100", country:"poland")
            expect(company).to be_valid
          end

          it 'zip_code is nil' do
            company.build_address(street:"abc", city: "qwe", zip_code:nil, country:"poland")
            expect(company).to be_valid
          end

        end
      end

      context 'invalid' do
        it 'street is nil' do
          user.build_address(street:nil, city: "qwe", zip_code:"87-100", country:"poland")
          expect(user).not_to be_valid
        end

        it 'city is nil' do
          user.build_address(street:"abc", city: nil, zip_code:"87-100", country:"poland")
          expect(user).not_to be_valid
        end

        it 'country is nil' do
          user.build_address(street:"abc", city: "qwe", zip_code:"87-100", country: nil)
          expect(user).not_to be_valid
        end

        it 'zip_code is nil' do
          user.build_address(street:"abc", city: "qwe", zip_code:nil, country:"poland")
          expect(user).not_to be_valid
        end

        it 'country is nil' do
          company = user.create_company(name:"chimera")
          company.build_address(street:"abc", city: "qwe", zip_code:"87-100", country: nil)
          expect(company).not_to be_valid
        end
      end
    end

    context "convert_country_to_alpha2" do
      let(:user) { User.new(first_name:"ruby", last_name:"rails", email_address:"test@chimera.com") }
      before(:each) { user.save }

      context 'valid' do
        it 'for country in english' do
          user.build_address(street:"abc", city: "qwe", zip_code:"87-100", country:"poland")
          expect(user).to be_valid
        end

        it 'for country in alpha2' do
          user.build_address(street:"abc", city: "qwe", zip_code:"1001", country:"af")
          expect(user).to be_valid
        end
      end

      context 'invalid' do
        it 'country doesnt exist' do
          user.build_address(street:"abc", city: "qwe", zip_code:"1001", country:"awdwadaw")
          expect(user).not_to be_valid
          expect(user.errors.messages.first.last).to eq ["does'n exist, please write in English"]
        end
      end
    end


    context 'zip_code' do
      let(:user) { User.new(first_name:"ruby", last_name:"rails", email_address:"test@chimera.com") }
      before(:each) { user.save }

      context 'valid' do
        it 'when zip_code exist in country (correct format)' do
          user.build_address(street:"abc", city: "qwe", zip_code:"1001", country:"Afghanistan")
          expect(user).to be_valid
        end
      end

      context 'invalid' do
        it 'when zip_code doesnt exist in country (incorrect format)' do
          user.build_address(street:"abc", city: "qwe", zip_code:"1001", country:"Poland")
          expect(user).not_to be_valid
        end
      end
    end
  end
end
