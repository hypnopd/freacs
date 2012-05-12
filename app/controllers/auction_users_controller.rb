class AuctionUsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def new
    @users = User.all
    @auction = Auction.find params[:auction_id]
  end

  def create
    if params[:users]
      params[:users].each do |user_id|
        begin
          AuctionUser.create!(:user_id=>user_id, :auction_id => params[:auction_id])
        end
      end
      redirect_to auction_path(params[:auction_id]), :notice => t("auction_users.flash.notice.add_users", :count => params[:users].count)
    else
      @auction = Auction.find params[:auction_id]
      redirect_to new_auction_auction_user_path(@auction), :alert => t("auction_users.flash.alert.no_users")
    end
  end

  def destroy
    @auction_user = AuctionUser.find(params[:id])
    @auction_user.destroy
    if @auction_user.destroyed?
      redirect_to auction_path(params[:auction_id]), :notice => t("deleted")
    else
      redirect_to auction_path(params[:auction_id]), :alert => t("not_deleted")
    end
  end
end
