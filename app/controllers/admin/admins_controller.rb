class Admin::AdminsController < ApplicationController

  before_filter :authenticate_admin!

  def index
  end

  def show
  end
end
