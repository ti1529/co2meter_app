class BranchesController < ApplicationController
  before_action :correct_company, only: %i[ show edit update destroy ]
  before_action :set_branch, only: %i[ show edit update destroy ]

  # GET /branches or /branches.json
  def index
    @branches = current_user.company.branches
  end

  # GET /branches/1 or /branches/1.json
  def show
  end

  # GET /branches/new
  def new
    @branch = Branch.new
  end

  # GET /branches/1/edit
  def edit
  end

  # POST /branches or /branches.json
  def create
    @branch = current_user.company.branches.new(branch_params)

    respond_to do |format|
      if @branch.save
        format.html { redirect_to branches_path, notice: t(".notice") }
        format.json { render :show, status: :created, location: @branch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branches/1 or /branches/1.json
  def update
    respond_to do |format|
      if @branch.update(branch_params)
        format.html { redirect_to @branch, notice: t(".notice") }
        format.json { render :show, status: :ok, location: @branch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1 or /branches/1.json
  def destroy
    @branch.destroy!

    respond_to do |format|
      format.html { redirect_to branches_path, status: :see_other, notice: t(".notice") }
      format.json { head :no_content }
    end
  end

  def inquire
    @branch = Branch.new

    prefecture = params[:ask_prefecture]
    city = params[:ask_city]

    if prefecture.present? && city.present?
      @chat_response = ChatgptService.new.get_city_category(prefecture, city)

      render :new
    else
      flash.now[:notice] = "都道府県、市町村を入力してください。"
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def branch_params
      params.require(:branch).permit(:name, :workplace_type, :city_category, :postcode, :prefecture, :city, :address_line1, :address_line2)
    end

    def correct_company
      @company = Branch.find(params[:id]).company
      redirect_to root_path, notice: t("common.alert") unless current_user_company?(@company)
    end
end
