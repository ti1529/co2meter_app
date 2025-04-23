class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :branch_fiscal_year_stats, dependent: :destroy
  belongs_to :company

  validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.company = Company.find_or_create_by!(name: "ゲスト会社", contact_name: "ゲスト", status: 0)
    end
  end

  def self.guest_admin
    find_or_create_by!(email: "guest_admin@example.com") do |admin|
      admin.password = SecureRandom.urlsafe_base64
      admin.name = "ゲスト（管理者）"
      admin.admin = true
      admin.company = Company.find_or_create_by!(name: "ゲスト会社", contact_name: "ゲスト", status: 0)
    end
  end
end
