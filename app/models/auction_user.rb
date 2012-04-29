class AuctionUser < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :auction
  has_many :offers
end
