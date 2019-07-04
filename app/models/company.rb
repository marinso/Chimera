class Company < ApplicationRecord
  belongs_to :user
  has_one :address, as: :addressable
  validates_length_of :name, maximum: 200
  accepts_nested_attributes_for :address
end
