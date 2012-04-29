class Offer < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :offerable, :polymorphic => true
  belongs_to :auction_user
end
