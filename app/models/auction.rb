class Auction < ActiveRecord::Base
  attr_accessible :name, :total_price_weight, :rank, :best_price, :computing_criteria
  has_many :auction_users
  has_many :users, :through => :auction_users
  has_many :items
  has_many :conditions


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
end
