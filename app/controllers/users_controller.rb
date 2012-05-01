class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    if current_user.competitor?
      @users = current_user.children
    else
      @users = User.accessible_by(current_ability, :read)
    end
  end

  def show
    @user = User.find params[:id]
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    if @user.destroyed?
      redirect_to users_path, :notice => t("deleted")
    else
      redirect_to users_path, :alert => t("not_deleted")
    end
  end
end
