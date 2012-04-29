class Offer < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :offerable, :polymorphic => true

end
