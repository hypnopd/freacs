class Item < ActiveRecord::Base
  attr_accessible :amount, :name, :unit
  has_many :offers, :as => :offerable
end
