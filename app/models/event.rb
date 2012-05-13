class Event < ActiveRecord::Base
  attr_accessible :name, :auction_id
  belongs_to :auction
end
