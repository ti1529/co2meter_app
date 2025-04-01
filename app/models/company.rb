class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :branches, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :contact_name, presence: true, length: { maximum: 255 }
  validates :contact_email, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :status, presence: true

  enum status: {
    unsubscribed: 0,
    active: 1,
    suspended: 2,
    terminated: 3
  }
end
