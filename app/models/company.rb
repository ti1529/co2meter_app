class Company < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :contact_name, presence: true, length: { maximum: 255 }
  validates :contact_email, length: { maximum: 255 }
  validates :status, presence: true

  enum status: {
    unsubscribed: 0,
    active: 1,
    suspended: 2,
    terminated: 3
  }
end
