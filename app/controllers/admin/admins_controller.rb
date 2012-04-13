class Admin::AdminsController < ApplicationController

  before_filter :authenticate_admin!

  def index
    @admins = Admin.all
  end

  def show
  end
end
