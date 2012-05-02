class ItemsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @auction = Auction.find params[:auction_id]
    @item = Item.new(:auction => @auction)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    @auction =Auction.find params[:auction_id]
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])
    @auction = Auction.find params[:auction_id]
    @item.auction = @auction
    respond_to do |format|
      if @item.save
        format.html { redirect_to auction_path(@auction), notice: t("items.flash.notice.created") }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])
    @auction = Auction.find params[:auction_id]

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @auction, notice: t("items.flash.notice.updated") }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    @auction = Auction.find params[:auction_id]

    if @item.destroyed?
      redirect_to auction_path(@auction), :notice => t("deleted")
    else
      redirect_to auction_path(@auction), :alert => t("not_deleted")
    end
  end
end
