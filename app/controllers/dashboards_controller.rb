class DashboardsController < ApplicationController
  def index
    @branches = current_user.company.branches
    @fiscal_years = BranchFiscalYearStat.joins(:branch).where( branches: { company_id: 29 }).distinct.pluck(:fiscal_year)

    @q = BranchFiscalYearStat.ransack(params[:q])
    @q.sorts = [ "fiscal_year asc", "branch_id asc" ] if @q.sorts.empty?
    @branch_fiscal_year_stats = @q.result(distinct: true)
                                  .joins(:branch)
                                  .includes(:branch)
                                  .where(branches: { company_id: current_user.company.id })

    @selection_fiscal_years = @branch_fiscal_year_stats.group_by(&:fiscal_year).keys
    @selection_branches = Branch.where(id: @branch_fiscal_year_stats.group_by(&:branch_id).keys)

    @co2_emissions_by_year =
      @selection_fiscal_years.map do |year|
        co2_by_year =
          @branch_fiscal_year_stats.where(fiscal_year: year).map(&:calculated_co2_emission)
        co2_by_year.sum.round(2)
      end

    @total_co2_emissions = @branch_fiscal_year_stats
                            .map(&:calculated_co2_emission)
  end
end
