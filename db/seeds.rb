# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#default admin
puts "Creation of Admin user"
admin = User.create! :email => "admin@admin.com", :password => "admin11", :password_confirmation => "admin11",
                     :confirmed_at => DateTime.now
admin.update_attribute :parent, admin
puts "Created Admin user: " << admin.email

#default user
puts "Creation of User"
user = User.create! :email => "user@user.com", :password => "user11", :password_confirmation => "user11",
                    :confirmed_at => DateTime.now
user.update_attribute :parent, admin
puts "Created User: " << user.email
