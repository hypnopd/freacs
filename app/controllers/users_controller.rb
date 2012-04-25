class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    if current_user.admin?
      @users = User.all
    elsif current_user.creator? || current_user.competitor?
      @users = current_user.children
    end
  end

  def show
  end
end
