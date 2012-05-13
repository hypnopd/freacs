class Offer < ActiveRecord::Base

  attr_accessible :value, :offerable_type, :offerable_id, :auction_user_id
  belongs_to :offerable, :polymorphic => true
  belongs_to :auction_user
end
