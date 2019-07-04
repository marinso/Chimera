class Address < ApplicationRecord

  belongs_to :addressable, polymorphic: true
  validate :validates_for_user
  validate :convert_country_to_alpha2
  alias_attribute :country_alpha2, :country # potrzebne do validacji zip_code
  validates_zipcode :zip_code, allow_blank: true

  private

    def validates_for_user
       return unless addressable_type == "User"

       errors.add(:street, "cannot be empty") if street.nil?
       errors.add(:city, "cannot be empty")  if city.nil?
       errors.add(:zip_code, "cannot be empty") if zip_code.nil?
       errors.add(:country, "cannot be empty") if country.nil?
    end


    def convert_country_to_alpha2
      return true if ISO3166::Country.find_country_by_alpha2(country) || country.blank?# zabezpieczenie jesli ktoś już wpisał w alpha2 lub nie wpisał wcale

      alpha2 = ISO3166::Country.find_country_by_name(country)&.alpha2
      if alpha2
        self.country = alpha2
      else
        errors.add(:country, "does't exist, please write in English")
      end
    end
end
