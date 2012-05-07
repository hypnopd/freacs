class Auction < ActiveRecord::Base
  attr_accessible :name, :total_price_weight, :rank, :best_price, :computing_criteria
  has_many :auction_users
  has_many :users, :through => :auction_users
  has_many :items
  has_many :conditions
end
