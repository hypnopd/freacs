# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#default admin
puts "Creation of Admin user"
admin = User.create! :email => "admin@admin.com", :password => "admin12", :password_confirmation => "admin12", :confirmed_at => DateTime.now
puts "Created Admin user: " << admin.email

#default user
puts "Creation of User"
user = User.create! :email => "user@user.com", :password => "user12", :password_confirmation => "user12", :confirmed_at => DateTime.now
puts "Created User: " << user.email
