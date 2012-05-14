class AuctionsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /auctions
  # GET /auctions.json
  def index
    if current_user.admin? || current_user.creator?
      @auctions = Auction.all
    else
      @auctions = current_user.auctions
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @auctions }
    end
  end

  # GET /auctions/1
  # GET /auctions/1.json
  def show
    @auction = Auction.find(params[:id])
    @auction_users = AuctionUser.find_all_by_auction_id(params[:id])
    if (@auction.phase == Auction::PHASES[:first]) || (@auction.phase == Auction::PHASES[:start]) && !(current_user.auction_admin?)
      @auction_user = AuctionUser.find_by_user_id(current_user.id)
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @auction }
    end
  end

  # GET /auctions/new
  # GET /auctions/new.json
  def new
    @auction = Auction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @auction }
    end
  end

  # GET /auctions/1/edit
  def edit
    @auction = Auction.find(params[:id])
  end

  # POST /auctions
  # POST /auctions.json
  def create
    @auction = Auction.new(params[:auction])
    @auction.phase = Auction::PHASES[:init]
    respond_to do |format|
      if @auction.save
        format.html { redirect_to @auction, notice: t('auctions.flash.notice.created') }
        format.json { render json: @auction, status: :created, location: @auction }
      else
        format.html { render action: "new" }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /auctions/1
  # PUT /auctions/1.json
  def update
    @auction = Auction.find(params[:id])

    respond_to do |format|
      if @auction.update_attributes(params[:auction])
        format.html { redirect_to @auction, :notice => t("auctions.flash.notice.updated") }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auctions/1
  # DELETE /auctions/1.json
  def destroy
    @auction = Auction.find(params[:id])
    @auction.destroy

    if @auction.destroyed?
      redirect_to auctions_path, notice: t("deleted")
    else
      redirect_to auctions_path, alert: t("not_deleted")
    end
  end

  def permissions
    @auction = Auction.find params[:id]
  end

  def send_invitations
    @auction = Auction.find params[:id]
    @auction.phase = Auction::PHASES[:first]
    if @auction.save
      redirect_to @auction, :notice => t("auctions.flash.notice.sent")
    else
      @auction.phase = Auction::PHASES[:init]
      render :show, flash.now[:alert] => t("auctions.flash.alert.cannot_send")
    end
  end

  def total_price_weight
    @auction = Auction.find params[:id]
  end

  def start_auction
    @auction = Auction.find params[:id]
    @auction.phase = Auction::PHASES[:start]
    if @auction.save
      redirect_to @auction, :notice => t("auctions.flash.notice.start")
    else
      @auction.phase = Auction::PHASES[:first]
      render :show, :alert => t("auctions.flash.alert.cannot_start")
    end
  end

  def finish_auction
    @auction = Auction.find params[:id]
    @auction.phase = Auction::PHASES[:finish]
    if @auction.save
      redirect_to @auction, :notice => t("auctions.flash.notice.start")
    else
      @auction.phase = Auction::PHASES[:start]
      render :show, flash.now[:alert] => t("auctions.flash.alert.cannot_start")
    end
  end

end
