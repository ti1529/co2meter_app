class BranchFiscalYearStatsController < ApplicationController
  before_action :set_branch_fiscal_year_stat, only: %i[ show edit update destroy ]

  # GET /branch_fiscal_year_stats or /branch_fiscal_year_stats.json
  def index
    @branch_fiscal_year_stats = BranchFiscalYearStat.all
  end

  # GET /branch_fiscal_year_stats/1 or /branch_fiscal_year_stats/1.json
  def show
  end

  # GET /branch_fiscal_year_stats/new
  def new
    @branch_fiscal_year_stat = BranchFiscalYearStat.new
  end

  # GET /branch_fiscal_year_stats/1/edit
  def edit
  end

  # POST /branch_fiscal_year_stats or /branch_fiscal_year_stats.json
  def create
    @branch_fiscal_year_stat = BranchFiscalYearStat.new(branch_fiscal_year_stat_params)

    respond_to do |format|
      if @branch_fiscal_year_stat.save
        format.html { redirect_to @branch_fiscal_year_stat, notice: "Branch fiscal year stat was successfully created." }
        format.json { render :show, status: :created, location: @branch_fiscal_year_stat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @branch_fiscal_year_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branch_fiscal_year_stats/1 or /branch_fiscal_year_stats/1.json
  def update
    respond_to do |format|
      if @branch_fiscal_year_stat.update(branch_fiscal_year_stat_params)
        format.html { redirect_to @branch_fiscal_year_stat, notice: "Branch fiscal year stat was successfully updated." }
        format.json { render :show, status: :ok, location: @branch_fiscal_year_stat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @branch_fiscal_year_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branch_fiscal_year_stats/1 or /branch_fiscal_year_stats/1.json
  def destroy
    @branch_fiscal_year_stat.destroy!

    respond_to do |format|
      format.html { redirect_to branch_fiscal_year_stats_path, status: :see_other, notice: "Branch fiscal year stat was successfully destroyed." }
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
      params.require(:branch_fiscal_year_stat).permit(:fiscal_year, :branch_id, :annual_working_days, :annual_employee_count, :user_id)
    end
end
