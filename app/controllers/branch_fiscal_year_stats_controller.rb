class BranchFiscalYearStatsController < ApplicationController
  before_action :correct_company, only: %i[ edit update destroy]
  before_action :set_branch_fiscal_year_stat, only: %i[ edit update destroy ]

  # GET /branch_fiscal_year_stats or /branch_fiscal_year_stats.json
  def index
    @q = BranchFiscalYearStat.ransack(params[:q])
    @q.sorts = [ "fiscal_year desc", "branch_id asc" ] if @q.sorts.empty?
    @branch_fiscal_year_stats = @q.result(distinct: true)
                                  .joins(:branch)
                                  .includes(:branch, :updater)
                                  .where(branches: { company_id: current_user.company.id })

    @fiscal_years = BranchFiscalYearStat.joins(:branch)
                                        .where(branches: { company_id: current_user.company.id })
                                        .distinct.pluck(:fiscal_year)
    @branches = current_user.company.branches
  end

  # GET /branch_fiscal_year_stats/new
  def new
    @branch_fiscal_year_stat = BranchFiscalYearStat.new(fiscal_year: params[:fiscal_year], branch_id: params[:branch_id])
    @branches = current_user.company.branches
  end

  # GET /branch_fiscal_year_stats/1/edit
  def edit
    @branches = current_user.company.branches
  end

  # POST /branch_fiscal_year_stats or /branch_fiscal_year_stats.json
  def create
    # @branch_fiscal_year_stat = BranchFiscalYearStat.new(branch_fiscal_year_stat_params)
    @branch_fiscal_year_stat = current_user.branch_fiscal_year_stats.new(branch_fiscal_year_stat_params)

    respond_to do |format|
      if @branch_fiscal_year_stat.save
        format.html { redirect_to branch_fiscal_year_stats_path, notice: t(".notice") }
        format.json { render :index, status: :created, location: @branch_fiscal_year_stat }
      else
        @branches = current_user.company.branches
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @branch_fiscal_year_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branch_fiscal_year_stats/1 or /branch_fiscal_year_stats/1.json
  def update
    respond_to do |format|
      if @branch_fiscal_year_stat.update(branch_fiscal_year_stat_params)
        format.html { redirect_to branch_fiscal_year_stats_path, notice: t(".notice") }
        format.json { render :index, status: :ok, location: @branch_fiscal_year_stat }
      else
        @branches = current_user.company.branches
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @branch_fiscal_year_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branch_fiscal_year_stats/1 or /branch_fiscal_year_stats/1.json
  def destroy
    @branch_fiscal_year_stat.destroy!

    respond_to do |format|
      format.html { redirect_to branch_fiscal_year_stats_path, status: :see_other, notice: t(".notice") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch_fiscal_year_stat
      @branch_fiscal_year_stat = BranchFiscalYearStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def branch_fiscal_year_stat_params
      params.require(:branch_fiscal_year_stat).permit(:fiscal_year, :branch_id, :annual_working_days, :annual_employee_count)
    end

    def correct_company
      @company = BranchFiscalYearStat.find(params[:id]).branch.company
      redirect_to root_path, notice: t("common.alert") unless current_user_company?(@company)
    end
end
