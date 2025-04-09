class UsersController < ApplicationController
  def index
    @users = current_user.company.users
  end

  def show
    @user = User.find(params[:id])
  end
end
