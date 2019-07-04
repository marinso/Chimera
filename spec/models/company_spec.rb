require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'associations' do
      it { should belong_to(:user) }
      it { should have_one(:address) }
  end

  describe 'validations' do
     it { should validate_length_of(:name).is_at_most(200)}
  end

  describe 'nested_attributes' do
    it { should accept_nested_attributes_for(:address) }
  end
end
