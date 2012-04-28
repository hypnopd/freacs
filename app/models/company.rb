class Company < ActiveRecord::Base
  # attr_accessible :title, :body
has_many :users

validates :name, :presence => true
end
