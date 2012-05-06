class Item < ActiveRecord::Base
  attr_accessible :amount, :name, :unit, :auction, :description
  has_many :offers, :as => :offerable
  belongs_to :auction

  validates :name, :unit, :amount, :presence => true

end
