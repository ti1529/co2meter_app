class Branch < ApplicationRecord
  belongs_to :company

  validates :name, presence: true, length: { maximum: 255 }
  validates :workplace_type, presence: true
  validates :city_category, presence: true
  # validates :postcode, length: { is: 7 }
  validates :prefecture, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 255 }
  validates :address_line1, length: { maximum: 255 }
  validates :address_line2, length: { maximum: 255 }
  validates :company_id, presence: true

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
end
