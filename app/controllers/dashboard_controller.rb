class DashboardController < ApplicationController
  def index
    # @branch_fiscal_year_stats = BranchFiscalYearStat.all
    @q = BranchFiscalYearStat.ransack(params[:q])
    @q.sorts = [ "fiscal_year asc", "branch_id asc" ] if @q.sorts.empty?
    @branch_fiscal_year_stats = @q.result(distinct: true).joins(:branch).includes(:branch)
  end
end
