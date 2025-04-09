class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ edit update destroy ]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @companies = Company.all
  end

  def create
    # company = Company.find_by(id: user_params[:company_id])
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = t(".notice")
      redirect_to admin_users_path
    else
      @companies = Company.all
      render :new
    end
  end
  
  def edit

  end

  def update

  end

  def destroy

  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :company_id, :email, :password, :password_confirmation, :admin)
  end

end
