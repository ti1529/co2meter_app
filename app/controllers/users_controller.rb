class UsersController < ApplicationController
  before_action :correct_user, only: [:show]
  def index
    @users = current_user.company.users
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user?(@user)
  end
end
