class Event < ActiveRecord::Base
  attr_accessible :name
  belongs_to :auction
end
