class Auction < ActiveRecord::Base
  attr_accessible :name, :total_price_weight, :rank, :best_price, :computing_criteria, :phase, :invitation
  has_many :auction_users
  has_many :users, :through => :auction_users
  has_many :items, :dependent => :destroy
  has_many :conditions, :dependent => :destroy
  has_one :invitation, :dependent => :destroy
  has_many :events, :dependent => :destroy

  validates_presence_of :name
  validate :invitations_sending

  PHASES = {:init => "initialization", :sent => "sent_invitations", :first => "first_offers"}

  def invitations_sending
    if phase == Auction::PHASES[:first]
      unless users.count > 2 && check_competitors_count > 1
        errors.add(I18n.t("auctions.competitors_count"), I18n.t("auctions.errors.not_enough"))
      end
      unless items.count > 0
        errors.add(I18n.t("auctions.items_count"), I18n.t("auctions.errors.not_enough"))
      end
      unless total_percentage == 100
        errors.add(I18n.t("auctions.weights"), I18n.t("auctions.errors.not_100"))
      end
      unless invitation
        errors.add(I18n.t("invitations.invitation"), I18n.t("auctions.errors.not_exist"))
      end
    end
  end


  def total_percentage
    if conditions
      result = 0
      conditions.each do |cond|
        result += cond.percentage if cond.percentage
      end
      total_price_weight ? total_price_weight + result : result
    elsif total_price_weight
      total_price_weight
    else
      0
    end
  end

  private

  def check_competitors_count
    users.find_all {|user| user.role == "competitor"}.count
  end
end
