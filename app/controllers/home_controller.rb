class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :index

  def welcome
    redirect_to new_user_session_path, :alert => flash[:alert]
  end

  def index
    @auctions = current_user.auctions
  end
end
