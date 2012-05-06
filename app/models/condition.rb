class Condition < ActiveRecord::Base
  attr_protected :auction
  attr_accessible :name, :percentage, :description
  has_many :offers, :as => :offerable
  belongs_to :auction

  validates_presence_of :name, :auction
end
