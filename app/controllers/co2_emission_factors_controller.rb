class Co2EmissionFactorsController < ApplicationController
  before_action :set_co2_emission_factor, only: %i[ edit update destroy ]

  # GET /co2_emission_factors or /co2_emission_factors.json
  def index
    @co2_emission_factors = Co2EmissionFactor.all
  end

  # GET /co2_emission_factors/new
  def new
    @co2_emission_factor = Co2EmissionFactor.new
  end

  # GET /co2_emission_factors/1/edit
  def edit
  end

  # POST /co2_emission_factors or /co2_emission_factors.json
  def create
    @co2_emission_factor = Co2EmissionFactor.new(co2_emission_factor_params)

    respond_to do |format|
      if @co2_emission_factor.save
        format.html { redirect_to co2_emission_factors_path, notice: t(".notice") }
        format.json { render :index, status: :created, location: @co2_emission_factor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @co2_emission_factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /co2_emission_factors/1 or /co2_emission_factors/1.json
  def update
    respond_to do |format|
      if @co2_emission_factor.update(co2_emission_factor_params)
        format.html { redirect_to co2_emission_factors_path, notice: t(".notice") }
        format.json { render :index, status: :ok, location: @co2_emission_factor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @co2_emission_factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /co2_emission_factors/1 or /co2_emission_factors/1.json
  def destroy
    @co2_emission_factor.destroy!

    respond_to do |format|
      format.html { redirect_to co2_emission_factors_path, status: :see_other, notice: t(".notice") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_co2_emission_factor
      @co2_emission_factor = Co2EmissionFactor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def co2_emission_factor_params
      params.require(:co2_emission_factor).permit(:fiscal_year, :workplace_type, :city_category, :co2_emission_factor, :co2_emission_factor_unit)
    end
end
