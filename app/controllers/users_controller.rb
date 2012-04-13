class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = Users.all
  end

  def show
  end
end
