class Item < ActiveRecord::Base
  attr_protected :auction
  attr_accessible :amount, :name, :unit, :description, :min, :max
  has_many :offers, :as => :offerable
  belongs_to :auction

  validates :name, :unit, :amount, :presence => true

end
