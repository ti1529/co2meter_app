class Co2EmissionFactor < ApplicationRecord
  validates :fiscal_year, presence: true, length: { is: 4 }, uniqueness: { scope: [ :workplace_type, :city_category ] }
  validates :workplace_type, presence: true
  validates :city_category, presence: true
  validates :co2_emission_factor, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :co2_emission_factor_unit, presence: true, length: { maximum: 255 }

  enum workplace_type: {
    office: 0,
    factory: 1
  }
  enum city_category: {
    major_city: 0,
    medium_city: 1,
    small_city_a: 2,
    small_city_b: 3,
    rural: 4
  }

  def self.ransackable_attributes(auth_object = nil)
    [ "fiscal_year", "workplace_type", "city_category" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
