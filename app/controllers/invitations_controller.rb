class InvitationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /invitations
  # GET /invitations.json
  def index
    @invitations = Invitation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invitations }
    end
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    @auction = Auction.find params[:auction_id]
    @invitation = Invitation.find_by_auction_id(params[:auction_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invitation }
    end
  end

  # GET /invitations/new
  # GET /invitations/new.json
  def new
    @auction = Auction.find params[:auction_id]
    @invitation = Invitation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invitation }
    end
  end

  # GET /invitations/1/edit
  def edit
    @auction = Auction.find params[:auction_id]
    @invitation = Invitation.find_by_auction_id @auction.id
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(params[:invitation])
    @auction = Auction.find params[:auction_id]
    @invitation.auction = @auction

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @auction, :notice => t("invitations.flash.notice.created") }
        format.json { render json: @invitation, status: :created, location: @invitation }
      else
        format.html { render action: "new" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invitations/1
  # PUT /invitations/1.json
  def update
    @invitation = Invitation.find_by_auction_id(params[:auction_id])
    @auction = Auction.find params[:auction_id]

    if @invitation.update_attributes(params[:invitation])
      redirect_to @auction, :notice => t("invitations.flash.notice.created")
    else
      render action: "edit"
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation = Invitation.find_by_auction_id(params[:auction_id])
    @auction = Auction.find params[:auction_id]
    @invitation.destroy

    if @invitation.destroyed?
      redirect_to @auction, :notice => t("deleted")
    else
      redirect_to @auction, :notice => t("not_deleted")
    end
  end
end
