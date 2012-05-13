class OffersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /offers
  # GET /offers.json
  def index
    @auction = Auction.find params[:auction_id]
    @user = User.find params[:user_id]
    @auction_user = @user.auction_users.find_by_auction_id @auction.id
    @items_offers =[]
    @auction.items.each {|i| @items_offers << i.offers.where("auction_user_id=?", @auction_user.id).last }
    unless @auction.conditions.empty?
      @conditions_offers =[]
      @auction.conditions.each {|o| @conditions_offers << o.offers.where("auction_user_id=?", @auction_user.id).last }
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offers }
    end
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    @offer = Offer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /offers/new
  # GET /offers/new.json
  def new
    @auction = Auction.find params[:auction_id]
    @offer = Offer.new
    if params[:item_id]
      @item = Item.find params[:item_id]
      @offer.offerable = @item
    elsif params[:condition_id]
      @condition = Condition.find params[:condition_id]
      @offer.offerable = @condition
    end
    @offer.auction_user = @auction.auction_users.where("user_id=?", current_user.id).first
    puts "OFFER!!!#{@offer.inspect}"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @offer }
    end
  end

  # POST /offers
  # POST /offers.json
  def create
    @auction = Auction.find params[:auction_id]
    @offer = Offer.new(params[:offer])


    respond_to do |format|
      if @offer.save
        format.html { redirect_to @auction, :notice => t("offers.flash.notice.created")}
      else
        format.html { render action: "new" }
      end
    end
  end
end
