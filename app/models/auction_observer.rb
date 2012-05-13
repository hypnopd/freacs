class AuctionObserver < ActiveRecord::Observer
  observe :auction

  def before_save(model)
    if model.phase == Auction::PHASES[:first]
      Event.create!(:name => Auction::PHASES[:sent], :auction_id => model.id)
      model.users.each do |user|
        InvitationMailer.invitation_email(user, model.invitation).deliver
      end
    end
  end

  def after_create(model)
    if model.phase == Auction::PHASES[:init]
      Event.create!(:name => Auction::PHASES[:init], :auction_id => model.id)
    end
  end
end
