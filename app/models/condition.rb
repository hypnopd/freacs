class Condition < ActiveRecord::Base
  attr_protected :auction
  attr_accessible :name, :percentage, :description, :min, :max
  has_many :offers, :as => :offerable
  belongs_to :auction

  validates_presence_of :name, :auction

  def show_percentage
    wat = percentage ?  percentage.to_s : "0"
    puts "$$$$$$$#{wat}---#{wat.class}"
  end
end
