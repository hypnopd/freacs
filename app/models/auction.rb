class Auction < ActiveRecord::Base
  attr_accessible :name, :total_price_weight, :rank, :best_price, :computing_criteria, :phase, :invitation
  has_many :auction_users
  has_many :users, :through => :auction_users
  has_many :items, :dependent => :destroy
  has_many :conditions, :dependent => :destroy
  has_one :invitation, :dependent => :destroy
  has_many :events, :dependent => :destroy

  validates_presence_of :name
  validate :transition

  PHASES = {:init => "initialization",
            :sent => "sent_invitations",
            :first => "first_offers",
            :start => "started",
            :finish => "finished"}

  def transition
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
    elsif phase == Auction::PHASES[:start]
      offers_count = 0
      items.each do |item|
        item.offers.each do |offer|
          offer.auction_user.user.competitor?
            offers_count += 1
        end
      end
      if offers_count < 2
        errors.add(t("offers.offers"), t("auctions.errors.few_offers"))
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

  def compute_sum(user)
      @auction_user= auction_users.find_by_user_id user.id
      offers_values = []
      items.each do |item|
        offers_values << item.offers.where("auction_user_id =?", @auction_user.id).last.value.to_f
      end
      total_price = offers_values.inject(0.0) {|sum, ov| sum + ov}

      unless conditions.empty?
        cond_values = []
        conditions.each do |cond|
          cond_values << (cond.offers.where("auction_user_id =?", @auction_user.id).last.value.to_f * (cond.percentage.to_f/100.0))
        end
        puts "COND#{cond_values.inspect}"
        cond_values.inject(0) {|sum, cv| sum+cv} + (total_price.to_f * (total_price_weight.to_f/100.0))
      else
        total_price.to_f * (total_price_weight.to_f/100.0)
      end
  end

  private

  def check_competitors_count
    users.find_all {|user| user.role == "competitor"}.count
  end


end
