class Invitation < ActiveRecord::Base
  belongs_to :auction
  attr_protected :auction
  attr_accessible :body

  validates_presence_of :auction
end
