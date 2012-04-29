class Auction < ActiveRecord::Base
  attr_accessible :name
  has_many :auction_users
  has_many :users, :through => :auction_users
  has_many :items
  has_many :conditions
end
