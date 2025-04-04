class BranchFiscalYearStat < ApplicationRecord
  belongs_to :branch
  belongs_to :updater, class_name: "User", foreign_key: "user_id"

  validates :fiscal_year, presence: true, length: { is: 4 }
  validates :annual_working_days, presence: true, numericality: { less_than_or_equal_to: 365 }
  validates :annual_employee_count, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "fiscal_year", "branch_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "branch" ]
  end

  def calculated_co2_emission
    factor =  Co2EmissionFactor.find_by(
          fiscal_year: self.fiscal_year,
          workplace_type: self.branch.workplace_type,
          city_category: self.branch.city_category
        )&.co2_emission_factor
    return "データなし" if factor.blank?
    (factor * self.annual_working_days * self.annual_employee_count) / 1000
  end
end
