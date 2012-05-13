class AuctionObserver < ActiveRecord::Observer
  observe :auction

  def before_save(model)
    if model.phase == Auction::PHASES[:sent]
      Event.create!(:name => I18n.t("#{Auction::PHASES[:sent]}"), :auction_id => model.id)
    end
  end
end
