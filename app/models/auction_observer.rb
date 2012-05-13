class AuctionObserver < ActiveRecord::Observer
  observe :auction

  def before_save(model)
    if model.phase == Auction::PHASES[:sent]
      Event.create!(:name => I18n.t("#{Auction::PHASES[:sent]}"), :auction_id => model.id)
      model.users.each do |user|
        InvitationMailer.invitation_email(user, model.invitation).deliver
      end
    end
  end
end
