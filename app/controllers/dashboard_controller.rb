class DashboardController < ApplicationController
  def index
    @q = BranchFiscalYearStat.ransack(params[:q])
    @q.sorts = [ "fiscal_year asc", "branch_id asc" ] if @q.sorts.empty?
    @branch_fiscal_year_stats = @q.result(distinct: true)
                                  .joins(:branch)
                                  .includes(:branch)
                                  .where(branches: { company_id: current_user.company.id })
  end
end
