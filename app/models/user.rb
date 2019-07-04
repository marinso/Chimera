class User < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  has_one :company, dependent: :destroy

  accepts_nested_attributes_for :address
  validates_associated :address
  accepts_nested_attributes_for :company

  validates :first_name, :last_name, :email_address, presence: true

  # validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails" } # ta validacja niżej lepiej się sprawdza

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email_address, presence: true, format: { with: VALID_EMAIL_REGEX, message: "only allows valid emails" }

  validates_date :date_of_birth, before: -> { Date.current }, allow_blank: true

  validates_length_of :first_name, :last_name, maximum: 100

  validate :matching_numer_to_country

  private

    def matching_numer_to_country
      return true if phone_number.blank?

      phone = phone_number
      match = Phonelib.valid_for_country? phone, address.country

      errors.add(:phone_number, "phone doesn't match to country") unless match
    end
end