class Condition < ActiveRecord::Base
  attr_accessible :name, :percentage, :type
  has_many :offers, :as => :offerable
  belongs_to :auction
end
